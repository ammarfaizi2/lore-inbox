Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSKBXx4>; Sat, 2 Nov 2002 18:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSKBXx4>; Sat, 2 Nov 2002 18:53:56 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:21256 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261518AbSKBXxz>; Sat, 2 Nov 2002 18:53:55 -0500
Date: Sun, 3 Nov 2002 00:59:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nero <neroz@iinet.net.au>
cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <200211030943.13730.neroz@iinet.net.au>
Message-ID: <Pine.LNX.4.44.0211030052410.13258-100000@serv>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk>
 <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
 <20021102232836.GD731@gallifrey> <200211030943.13730.neroz@iinet.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Nero wrote:

> OR, we could use the logical choice. GTK+ is on most systems, has hardly any 
> dependancies, is relatively small (compared to Qt) and doesn't require a C++ 
> compiler. Really, I think the only people being religious here are the ones 
> voting for Qt, as it just doesn't make sense to use it for such a thing.

Show me the source and we can continue this discussion. Right now qconf is 
included as replacement for the old xconfig. It shouldn't take to much 
effort to package it seperately. As soon as someone is interested in doing 
this for a distribtion I'll add the few missing bits.

bye, Roman

