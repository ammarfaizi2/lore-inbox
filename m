Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJALVT>; Tue, 1 Oct 2002 07:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSJALVT>; Tue, 1 Oct 2002 07:21:19 -0400
Received: from f9.pav0.hotmail.com ([64.4.33.80]:35078 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261581AbSJALVS>;
	Tue, 1 Oct 2002 07:21:18 -0400
X-Originating-IP: [213.4.13.153]
From: "Felipe Alfaro Solana" <felipe_alfaro@msn.com>
To: bonganilinux@mweb.co.za, tmolina@cox.net, linux-kernel@vger.kernel.org
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
Date: Tue, 01 Oct 2002 13:26:39 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F9B5KizJl82HBZyVKSN00014114@hotmail.com>
X-OriginalArrivalTime: 01 Oct 2002 11:26:40.0316 (UTC) FILETIME=[69778FC0:01C2693D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I didn't compile the IDE-SCSI support into the kernel... I always 
compile SCSI support as loadable modules, and IDE-CD also as a module. Will 
have a try to compile into the kernel and see if it crashes.

>Hi,
>
>Have you tried to build ide-scsi support into the kernel? I will
>try to compile the kernel with ide-scsi support as modules and see
>how it goes when I get home. I did write down the oops that i get
>and posted it on the list. I haven't got any feed back on it yet.
>
>The original post of the Oops is here
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.3/1493.html
>
>Thanx

_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

