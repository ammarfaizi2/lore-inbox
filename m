Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSLUVpR>; Sat, 21 Dec 2002 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSLUVpR>; Sat, 21 Dec 2002 16:45:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32269 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264983AbSLUVpR>;
	Sat, 21 Dec 2002 16:45:17 -0500
Date: Sat, 21 Dec 2002 22:52:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Bradford <john@grabjohn.com>
Cc: Sampson Fung <sampson@attglobal.net>, linux-kernel@vger.kernel.org,
       mec@shout.net, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: First Bug Found : RE: How to help new comers trying the v2.5x series kernels.
Message-ID: <20021221215250.GA1905@mars.ravnborg.org>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Sampson Fung <sampson@attglobal.net>, linux-kernel@vger.kernel.org,
	mec@shout.net, Roman Zippel <zippel@linux-m68k.org>
References: <000c01c2a930$754a6790$0100a8c0@noelpc> <200212212123.gBLLNEGI001935@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212212123.gBLLNEGI001935@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The MAINTAINERS file tells you who to contact, (as well as this list):
> 
> CONFIGURE, MENUCONFIG, XCONFIG
> P:      Michael Elizabeth Chastain

Despite the MAINTANERS file, roman Zippel is the right person to contact.
roman ripped out three different shell ased parsers and replaced them
with a single parser written in yacc and c.
During this process 2make menuconfig" functionality was altered.

Roman has the following address:
Roman Zippel <zippel@linux-m68k.org>

	Sam
