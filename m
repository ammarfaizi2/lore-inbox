Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266919AbRHBSlc>; Thu, 2 Aug 2001 14:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRHBSlM>; Thu, 2 Aug 2001 14:41:12 -0400
Received: from jalon.able.es ([212.97.163.2]:38036 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266919AbRHBSlK>;
	Thu, 2 Aug 2001 14:41:10 -0400
Date: Thu, 2 Aug 2001 20:46:58 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brad Stewart <bradmont@bradmont.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: university studies?
Message-ID: <20010802204658.A1175@werewolf.able.es>
In-Reply-To: <20010802111309.A29322@bradmont.net> <E15SN84-0001BC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15SN84-0001BC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 20:23:28 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010802 Alan Cox wrote:
>
>If you have few classes and a lot of 5000 line subroutines then worry, but
>there is no reason to assume that every ex basic programmer isnt going to
>pick up C++ and good software design practices just because they once 
>wrote basic
>-

I have seen several ex-Fortran programmers fill C code with wrappers to still
think on vectors ranging 1..N instead of 0..N-1. It is hard to loose traditions...

I would make students learn C++ first. There they can see how inneficient can be things
if misused, and how useless is Programming or Algorithmic Theory without low
level knowledge of the compiler system. Then you know that
database = databse + record is BAD, and database += record is not so bad...

Then go back to C and apply all you have learnt in C++.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7-ac3 #1 SMP Mon Jul 30 16:39:36 CEST 2001 i686
