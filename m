Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277576AbRJVSsj>; Mon, 22 Oct 2001 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJVSsU>; Mon, 22 Oct 2001 14:48:20 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:44040
	"EHLO awak") by vger.kernel.org with ESMTP id <S277576AbRJVSsA> convert rfc822-to-8bit;
	Mon, 22 Oct 2001 14:48:00 -0400
Subject: Re: old but actual HPT370 & VIA IDE issue
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Alexandre N. Safiullin" <alex_@unis-ru.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87lmi6ldo2.fsf@storm.dorms.msu.ru>
In-Reply-To: <87lmi6ldo2.fsf@storm.dorms.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.21 (Preview Release)
Date: 22 Oct 2001 20:42:13 +0200
Message-Id: <1003776133.9180.22.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le sam 20-10-2001 à 14:05, Alexandre N. Safiullin a écrit :
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
>  Hello!
> 
>  I have an ABIT KT7-RAID motherboard. It has two IDE controllers
>  VIA (UDMA66) and HPT370 (UDMA100 w/ RAID capabilities). 
>  The harddrive IBM DTLA 307030 is attached to HPT370 as a primary
>  master and usually detected as hde
> 
>  But after 2.4.6 or 2.4.7 the kernel begun to hang before the message 
> 
>  hde: IBM-DTLA-307030, ATA DISK drive

disable ACPI

	Xav

