Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbSKCTcI>; Sun, 3 Nov 2002 14:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSKCTcI>; Sun, 3 Nov 2002 14:32:08 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13072 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262389AbSKCTcE>; Sun, 3 Nov 2002 14:32:04 -0500
Message-Id: <200211031933.gA3JXUp29152@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.5.45: make menuconfig: (NEW) disappears once touched
Date: Sun, 3 Nov 2002 22:25:27 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200211031200.gA3C04p27922@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0211031359240.6949-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0211031359240.6949-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 14:24, Roman Zippel wrote:
> Hi,
>
> On Sun, 3 Nov 2002, Denis Vlasenko wrote:
> > If I go to any item marked (NEW), like this:
> >
> > < > Gameport support (NEW)
> >
> > and press y,n or m (does not matter), it gets
> > appropriately selected but '(NEW)' disappers.
> > Why?
>
> Because the option is not really new anymore, once you changed it.
> Any reason, why it should be kept (except that the old menuconfig did
> this)?

Heh... I thought it means 'new feature' and is part of a feature
description. New behaviour is ok with me.
--
vda
