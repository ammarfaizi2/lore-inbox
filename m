Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTENQ5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTENQ5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:57:19 -0400
Received: from waste.org ([209.173.204.2]:9931 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262609AbTENQ5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:57:16 -0400
Date: Wed, 14 May 2003 12:10:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030514171000.GB23380@waste.org>
References: <20030514032712.0c7fa0d1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514032712.0c7fa0d1.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 03:27:12AM -0700, Andrew Morton wrote:
> 
> Quite a lot of changes here.  Mostly additions, but some things have been
> crossed off.

Has handling of async write errors fallen off your radar? Should I
start pushing that again?

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
