Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSKCQSw>; Sun, 3 Nov 2002 11:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSKCQSw>; Sun, 3 Nov 2002 11:18:52 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:35854 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262147AbSKCQSu>; Sun, 3 Nov 2002 11:18:50 -0500
Date: Sun, 3 Nov 2002 17:24:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45: make menuconfig: (NEW) disappears once touched
In-Reply-To: <200211031200.gA3C04p27922@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0211031359240.6949-100000@serv>
References: <200211031200.gA3C04p27922@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Denis Vlasenko wrote:

> If I go to any item marked (NEW), like this:
> 
> < > Gameport support (NEW)
> 
> and press y,n or m (does not matter), it gets
> appropriately selected but '(NEW)' disappers.
> Why?

Because the option is not really new anymore, once you changed it.
Any reason, why it should be kept (except that the old menuconfig did 
this)?

bye, Roman

