Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268505AbUJPKoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268505AbUJPKoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 06:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUJPKoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 06:44:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:31750 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268505AbUJPKod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 06:44:33 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS while loading a Linux-2.6.8 module
Date: Sat, 16 Oct 2004 13:44:26 +0300
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.61.0410151030490.25333@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410151030490.25333@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410161344.26932.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 17:34, Richard B. Johnson wrote:
> 
> If you were to execute `strip` on a Linux-2.6.8 module,
> you can OOPS the kernel. Gotta patch? I'll test immediately.
> 
> 
> HeavyLink: falsely claims to have parameter shmem
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
> 00000000
> *pde = 07469001
> Oops: 0000 [#1]
> SMP 
> Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm
                     ^^^^^^^^^
Is the source of this available anywhere?
--
vda

