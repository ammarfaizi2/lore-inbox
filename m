Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWJBSM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWJBSM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWJBSM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:12:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965217AbWJBSM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:12:28 -0400
Date: Mon, 2 Oct 2006 11:12:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] usb hubc build fix.patch prefix
Message-Id: <20061002111223.1e5943dc.akpm@osdl.org>
In-Reply-To: <20061002092737.7816b8f5.pj@sgi.com>
References: <20061002023720.9780.85391.sendpatchset@v0>
	<Pine.LNX.4.44L0.0610021003330.6651-100000@iolanthe.rowland.org>
	<20061002092737.7816b8f5.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 09:27:37 -0700
Paul Jackson <pj@sgi.com> wrote:

> Alan wrote:
> > There is no patch labelled usb-hubc-build-fix.patch anywhere in 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/
> > This suggests that the quilt archive is indeed messed up.
> 
> Thanks - good observation.
> 
> I see the same thing here.  The 2.6.18-mm2-broken-out.tar.bz2 I downloaded from
> 
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/2.6.18-mm2-broken-out.tar.bz2
> 
> has a file named broken-out/usb-hubc-build-fix.patch, but the broken out directory
> 
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/
> 
> does not have such a file.
> 

I screwed things up and attempted to fix things by hand post-release and
apparently screwed that up too.  (Matthias mailed me within ten minutes
telling me that the import-mm-into-git script had broken).  
