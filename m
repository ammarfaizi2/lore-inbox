Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSK3OCy>; Sat, 30 Nov 2002 09:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSK3OCy>; Sat, 30 Nov 2002 09:02:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9371 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261448AbSK3OCx>; Sat, 30 Nov 2002 09:02:53 -0500
Subject: Re: Problem with via82cxxx and vt8235
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: black666@inode.at
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211300129.32580.black666@inode.at>
References: <200211300129.32580.black666@inode.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Nov 2002 14:43:00 +0000
Message-Id: <1038667380.17209.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-30 at 00:29, Patrick Petermair wrote:
> Hi!
> 
> I have a MSI KT3Ultra2 Motherboard with a VT8235 southbridge. I'm currently 
> running kernel 2.4.19 - unfortunately it doesn't detect the southbridge, 
> so I cannot enable dma.
> I tried the patch from Vojtech Pavlik (via82cxxx), but then it hangs at 
> boot:
> 

Try the -ac tree firstly

