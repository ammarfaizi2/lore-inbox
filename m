Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276225AbRJDJpv>; Thu, 4 Oct 2001 05:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276246AbRJDJpl>; Thu, 4 Oct 2001 05:45:41 -0400
Received: from codepoet.org ([166.70.14.212]:47414 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S276225AbRJDJpb>;
	Thu, 4 Oct 2001 05:45:31 -0400
Date: Thu, 4 Oct 2001 03:46:00 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004034600.B29438@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org> <20011004113019.L22640@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011004113019.L22640@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.9-ac18-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 04, 2001 at 11:30:19AM +0300, Ville Herva wrote:
> On Thu, Oct 04, 2001 at 12:15:01AM -0600, you [Eric W. Biederman] claimed:
> > 
> > <snip size of glibc>
> 
> Where size is an issue, diet libc might be an alternative:
> 
> http://www.fefe.de/dietlibc/
> 
> (287kB statically linked zsh is not too shabby, I reckon.)

uClibc is also a nice alternative.  Works just great and uses glibc
header files.  I only fully support shared libs on x86 and arm
at the moment.  

http://cvs.uclinux.org/uClibc.html

(I need to update the webpage sometime)

> That and things like busybox:
> 
> http://busybox.lineo.com/

Why thanks.  I've sure worked hard to make it be nice and small...

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
