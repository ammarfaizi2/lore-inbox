Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVBNXuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVBNXuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVBNXuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:50:09 -0500
Received: from [205.233.219.253] ([205.233.219.253]:48022 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261290AbVBNXuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:50:00 -0500
Date: Mon, 14 Feb 2005 18:49:43 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 and disks
Message-ID: <20050214234943.GG9231@conscoop.ottawa.on.ca>
References: <1106250812.3413.10.camel@localhost.localdomain> <1106252627.3413.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106252627.3413.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 01:23:47PM -0700, Trever L. Adams wrote:
> By bridge chips I mean IEEE-1394 to IDE. Also, is it possible to set
> spin down time for these IDE disks through 1394? i.e. if they are
> inactive for 1 hour, I would like them to spin down. Is this possible?

Not currently.  I'm not sure if this is a hardware limitation or just
something that isn't implemented yet.

Jody

> 
> Trever
