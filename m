Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283661AbRLEBR5>; Tue, 4 Dec 2001 20:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283657AbRLEBRs>; Tue, 4 Dec 2001 20:17:48 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26125 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S283644AbRLEBRe> convert rfc822-to-8bit; Tue, 4 Dec 2001 20:17:34 -0500
Date: Wed, 5 Dec 2001 02:17:30 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011205021730.D28582@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2001, RaúlNúñez de Arenas Coronado wrote:

>     Why must I install Python in order to compile the kernel? I don't
> understand this. I think there are better alternatives, but kbuild
> seems to be imposed any way.

Because the Gods of the Kernel command so, simply put. I fail to see the
mutual implications of kbuild and CML2 however. I have until now seen
these as separate (independent of each other) efforts which are both
proposed for early 2.5.x inclusion.

> >What are the precise issues with Python? Just claiming it is an
> >issue is not useful for discussing this. Archive pointers are
> >welcome.
> 
>     Well, let's start writing kernel drivers with Python, Perl, PHP,
> awk, etc... And, why not, C++, Ada, Modula, etc...

Please don't mix the "layers" here. You don't need Python to run the
kernel.

>     The kernel should depend just on the compiler and assembler, IMHO.

less Documentation/Changes
/Current Minimal Requirements -- that's for running, BTW, not for
compiling. Oops.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
