Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSLGNIX>; Sat, 7 Dec 2002 08:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSLGNIX>; Sat, 7 Dec 2002 08:08:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262692AbSLGNIW>;
	Sat, 7 Dec 2002 08:08:22 -0500
Date: Sat, 7 Dec 2002 13:15:59 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: erik@hensema.xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207131559.GA737@gallifrey>
References: <997222131F7@vcnet.vc.cvut.cz> <slrnav3qp5.1c2.usenet@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnav3qp5.1c2.usenet@bender.home.hensema.net>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 13:11:50 up  1:40,  1 user,  load average: 0.00, 0.00, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Hensema (usenet@hensema.xs4all.nl) wrote:
> 
> Every half-decent installer autodetects all PCI devices. AND had lspci
> installed in the install image.

Yes, but wait till you find yourself stuck on a weird embedded board
with a small flash and a serial console and you are trying to debug the
PCI device you've built.

Sure in most cases you have lspci (and its friends); but why do people
want to deprecate a perfectly good tool that occasionally comes in
useful? (Make it a compile time option sure, remove it - no).

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
