Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288948AbSAFNa1>; Sun, 6 Jan 2002 08:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSAFNaR>; Sun, 6 Jan 2002 08:30:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288948AbSAFN37>;
	Sun, 6 Jan 2002 08:29:59 -0500
Date: Sun, 6 Jan 2002 13:29:57 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Binutils and the Linux kernel source finder
Message-ID: <20020106132957.GE22105@gallifrey>
In-Reply-To: <20020105180237.GF485@gallifrey> <20020106023953.GA1728@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020106023953.GA1728@codepoet.org>
User-Agent: Mutt/1.3.25i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.17 (i686)
X-Uptime: 13:27:28 up 1 day, 14:39,  4 users,  load average: 2.01, 1.95, 1.95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Andersen (andersen@codepoet.org) wrote:

> Note that uClinux (not ucLinux as on your page) does not natively

Oops - fixed that.

> run the ELF binary file format, but uses what is called the
> "Flat" binary format.  It is structurally much simpler (and
> therefore smaller) then ELF, but more importantly, this format
> helps us avoid needing to always use PIC and/or do tons of
> relocations.

OK.

> The uClinux toolchains for ARM and m68k (which are the two most
> commonly used architectures) are available from 
>     http://www.uclinux.org/pub/uClinux/m68k-elf-tools/

OK, I've added that - it could be said that a page entitled
'm68k-elf-tools' is perhaps not the obvious place to find stuff for m68k
and ARM that specifically produces something other than ELF :-)

> 
> Links to toolchains for other arches and _lots_ of help
> information can be found at 
>     http://home.at/uclinux/

Also added - but it breaks Javascript on Mozilla for me, and the menu
doesn't appear at all in Konqueror for me. It also doesn't have a
non-Javascript version - making it useless in simpler browsers.
It does however have a very nice penguin.

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
