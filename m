Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTCJW4N>; Mon, 10 Mar 2003 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTCJW4N>; Mon, 10 Mar 2003 17:56:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45497
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262452AbTCJW4M>; Mon, 10 Mar 2003 17:56:12 -0500
Subject: Re: Fix mem= options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030309221624.GA26517@elf.ucw.cz>
References: <20030309221624.GA26517@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047341629.16973.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Mar 2003 00:13:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 22:16, Pavel Machek wrote:
> Hi!
> 
> HPA told me bootloaders need to parse mem=, so we should invent other
> option for stuff like mem=exactmap. Please apply,

Its worse than that  grub does strstr(blah, "mem=") !

