Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285150AbRLRUyn>; Tue, 18 Dec 2001 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLRUyi>; Tue, 18 Dec 2001 15:54:38 -0500
Received: from mail.interware.hu ([195.70.32.130]:10911 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S285150AbRLRUx6>; Tue, 18 Dec 2001 15:53:58 -0500
Date: Tue, 18 Dec 2001 21:53:55 +0100 (CET)
From: <endre@interware.hu>
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
cc: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 doesn't boot (on K6-II)
In-Reply-To: <20011214164301.A512@Zenith.starcenter>
Message-ID: <Pine.LNX.4.33.0112182152340.32595-100000@dusk.interware.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *16GRFL-0002d0-00*yfqFhPofTPs* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Dec 2001, Sven Vermeulen wrote:

> When booting 2.4.17-rc1, the following text appears:
> -------------------------------------------- BEGIN --
> Loading 2.4.17-rc1.............
> Uncompressing Linux...
>
> ran out of input data
>
>   -- System halted
> --------------------------------------------- END ---

Check your installed kernel image, it may be truncated. This just
happened to me using kernel-image .deb: only part of the kernel image
got unpacked.

-m-

