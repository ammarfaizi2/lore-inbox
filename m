Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280647AbRKNPcu>; Wed, 14 Nov 2001 10:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280667AbRKNPco>; Wed, 14 Nov 2001 10:32:44 -0500
Received: from quimbies.gnus.org ([195.204.10.148]:38673 "EHLO
	quimbies.gnus.org") by vger.kernel.org with ESMTP
	id <S280647AbRKNPbU>; Wed, 14 Nov 2001 10:31:20 -0500
X-Now-Playing: Company Flow's _Funcrusher Plus_: "Krazy Kings"
To: arjanv@redhat.com
Cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
	<3BF285D7.8F5AAB6E@redhat.com>
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Wed, 14 Nov 2001 16:28:26 +0100
In-Reply-To: <3BF285D7.8F5AAB6E@redhat.com> (Arjan van de Ven's message of
 "Wed, 14 Nov 2001 14:55:19 +0000")
Message-ID: <m3zo5pe5id.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.104
 (i686-pc-linux-gnu)
X-Face: &w!^oO<W.WBH]FsTP:P0f9X6M-ygaADlA_)eF$<UwQzj7:C=Gi<a?/_4$LX^@$Qq7-O&XHp
 lDARi8e8iT<(A$LWAZD*xjk^')/wI5nG;1cNB>~dS|}-P0~ge{$c!h\<y
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

>> Hi folks - I'm having real problems getting our new dual CPU server
>> going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
> 
> Ehm you know that XP cpu's don't support SMP configuration ?

The XP processors aren't certified by AMD to work in SMP
configurations, but the XP and MP processors are identical.

I've got a Tyan Tiger w/ 2x Athlon XP 1800+ running 2.2.19, and it
works just fine.  (And compiles its kernel blindingly fast.  :-)  The
only Tyan-related problem I've heard people having is that it's quite
picky about what type of RAM it tolerates.  It must be registered ECC
RAM.

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
