Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262050AbSJKKWn>; Fri, 11 Oct 2002 06:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSJKKWn>; Fri, 11 Oct 2002 06:22:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:25861 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262050AbSJKKWn>; Fri, 11 Oct 2002 06:22:43 -0400
Date: Fri, 11 Oct 2002 14:27:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bob McElrath <bob+linux-kernel@mcelrath.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 fails to build on alpha (sys_sync gone?)
Message-ID: <20021011142758.B4014@jurassic.park.msu.ru>
References: <20021010201245.GK18973@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021010201245.GK18973@draal.physics.wisc.edu>; from bob+linux-kernel@mcelrath.org on Thu, Oct 10, 2002 at 03:12:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 03:12:45PM -0500, Bob McElrath wrote:
> What happened to sys_sync?!?  It isn't defined anywhere!

Just delete it in alpha_ksyms.c.

Ivan.
