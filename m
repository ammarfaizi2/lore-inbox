Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWHTVpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWHTVpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHTVpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:50312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751157AbWHTVpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:45:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Luka Marinko" <luka.marinko@gmail.com>
Subject: Re: question on pthreads
Date: Sun, 20 Aug 2006 21:32:15 +0000 (UTC)
Message-ID: <ecakcv$m06$1@sea.gmane.org>
References: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: clj8-137.dial-up.arnes.si
User-Agent: pan 0.108 (Mama's Little Joyboy Loves Lobsters, Lobsters)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 22:46:14 +0500, Irfan Habib wrote:

> Hi,
> 
> Where should I look for the code of the native Pthreads implemetation:
> 
> I've found this:
> http://pauillac.inria.fr/~xleroy/linuxthreads/
> 
> Supposedly from the site,it has been superceeded by NPTL by Ulrich
> Drepper, but I cant find the code for NPTL?

pthreads (whitch is now NPTL), is part of glibc and can be found at
http://www.gnu.org/software/libc/

You can find nice manual here, and overview
http://www.gnu.org/software/libc/manual/html_mono/libc.html

Also keep in mind that soem distros, patch their glibs, so you might want
to get sources from there

have a nice day,
Luka Marinko

