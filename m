Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161325AbWHDRGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbWHDRGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbWHDRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:06:13 -0400
Received: from 1wt.eu ([62.212.114.60]:26893 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161325AbWHDRGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:06:12 -0400
Date: Fri, 4 Aug 2006 18:55:51 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mtosatti@redhat.com,
       marcelo@kvack.org
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-ID: <20060804165550.GA26701@1wt.eu>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <20060802230058.0ff73025.zaitcev@redhat.com> <20060803062903.GA19176@1wt.eu> <200608040957.05034.benjamin.cherian.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608040957.05034.benjamin.cherian.kernel@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 09:57:04AM -0700, Benjamin Cherian wrote:
> Willy,
> 
> On Wednesday 02 August 2006 23:29, Willy Tarreau wrote:
> > Perfect. Patch queued, thanks Pete.
> 
> Do you know if it would be possible for this to get into 2.4.33? I know its 
> already at rc3, but it would be nice if this patch could be pushed out sooner 
> since 2.4.34 will probably not be out for a while. I would really appreciate 
> it. Thanks to both you and Pete for your help.

The problem is that Marcelo is very very busy those days (as you might have
noticed from the delay between each release), and there are a good bunch of
security fixes in -rc3 which should wait too much in -rc. Maybe an -rc4
would be OK, but I don't know if Marcelo has enough time to spend on yet
another RC. Otherwise, if I produce a 2.4.34-pre1 about one week after 2.4.33,
does that fit your needs ? I already have a few fixes waiting which might be
worth a first pre-release.

> Ben

Regards,
Willy

