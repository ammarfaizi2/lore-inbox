Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSKCDrH>; Sat, 2 Nov 2002 22:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSKCDrH>; Sat, 2 Nov 2002 22:47:07 -0500
Received: from 0wned.org ([207.164.207.21]:53770 "EHLO nitro.0wned.org")
	by vger.kernel.org with ESMTP id <S261597AbSKCDrG>;
	Sat, 2 Nov 2002 22:47:06 -0500
From: George Staikos <staikos@kde.org>
To: Nero <neroz@iinet.net.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Date: Sat, 2 Nov 2002 22:53:07 -0500
User-Agent: KMail/1.5
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <20021102232836.GD731@gallifrey> <200211030943.13730.neroz@iinet.net.au>
In-Reply-To: <200211030943.13730.neroz@iinet.net.au>
Cc: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211022253.07606.staikos@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 2, 2002 17:43, Nero wrote:

> thing. If you absolutely hate GTK+, there is menuconfig, and IIRC KDE have
> their own [external] kernel configurator utility.

   Please contact myself and/or Malte Starostik (kcmlinuz author) regarding 
the KDE kernel configurator.  We have full intentions to support the new 
system once it is in widespread use.  Support for the new system will not be 
in KDE 3.1 but it should be in KDE 3.2 if all goes as planned.

   If anyone has some feedback regarding the design we would also be 
interested in that.


   Additionally, to those who complain about Qt's size and dependencies:
   1) The 16MB Qt .gz (13MB .bz2) contains much more than just the library.  
it contains Qt Designer, example code, full and complete documentation for 
the entire library, etc.  That's not obscene in comparison with gtk+ and all 
accompanying RAD tools etc.  If for some reason 16MB vs 8.5MB really hurts, 
contact Trolltech and ask them if they will split the package up for you.

    2) Exactly what dependencies other than g++, yacc, and X11 devel libraries 
are you concerned about?  I'm not sure there are any others.  If you're 
really afraid of C++, I can assure you that it's not so scary, and you don't 
even have to look at the C++ code.  However if you must, there are tutorials 
available online.

   Anyhow, I think it's great to see a kernel config system that can have a 
GUI implemented with stdio, curses, Xlib, GTK and Qt.  That's clearly the 
best plan and they should all be available to choose from.

Thanks

-- 

George Staikos

