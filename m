Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSIPGnl>; Mon, 16 Sep 2002 02:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSIPGnl>; Mon, 16 Sep 2002 02:43:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56590 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S311885AbSIPGnk>; Mon, 16 Sep 2002 02:43:40 -0400
Message-Id: <200209160643.g8G6hVp18220@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dieter.Ferdinand@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nfs mount hangs, program is dead an i can't umount or kill the program
Date: Mon, 16 Sep 2002 09:38:26 -0200
X-Mailer: KMail [version 1.3.2]
References: <3D834AAB.14580.39F2BD5@localhost>
In-Reply-To: <3D834AAB.14580.39F2BD5@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 December 1969 22:00, Dieter Ferdinand wrote:
> hello,
> i have big problem with my nfs-mounts.
>
> sometimes, the nfs-mount is stalled an i can only reaktivate it, when i
> umount and mount it again.
>
> when a program is accessing this mount, and i can't kill it,i  must reboot
> the pc.

How do you mount it? What mount options? I suspect hard,nointr?
Please read mount manpage, post your kernel log and .config.
--
vda
