Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSA1UtW>; Mon, 28 Jan 2002 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSA1UtQ>; Mon, 28 Jan 2002 15:49:16 -0500
Received: from [195.66.192.167] ([195.66.192.167]:48903 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289375AbSA1Usg>; Mon, 28 Jan 2002 15:48:36 -0500
Message-Id: <200201282046.g0SKkLE24830@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rene Rebe <rene.rebe@gmx.net>, alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon Optimization Problem
Date: Mon, 28 Jan 2002 22:46:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: calin@ajvar.org, hassani@its.caltech.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0201281452480.9637-200000@rtlab.med.cornell.edu> <E16VIKU-0001f7-00@the-village.bc.nu> <20020128.212830.846943574.rene.rebe@gmx.net>
In-Reply-To: <20020128.212830.846943574.rene.rebe@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 January 2002 18:28, Rene Rebe wrote:
>     Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Im still not convinced touching the register on the 266 chipset at 0x95
> > is correct. I now have several reports of boxes that only work if you
> > leave it alone
>
> We have a Druon-700 box based on the "Asus A7V" lspci:

[snip]

> With an Athlon optimized 2.4.[16,17,18-pre7] all programs are getting
> sig-11s everytime. Even mem=nopentium doesn't help, using generic i386
> code generation seems to help. An Athlon optimized 2.4.4 kernel seems
> also to run fine (and running memtest86 for some hours did not showed
> a memory error ...).

Ugh... Does 686 kernel work?
--
vda
