Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264684AbSJUA7o>; Sun, 20 Oct 2002 20:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSJUA7o>; Sun, 20 Oct 2002 20:59:44 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:23794 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264684AbSJUA7n>; Sun, 20 Oct 2002 20:59:43 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <15795.21189.217477.279073@wombat.chubb.wattle.id.au>
Date: Mon, 21 Oct 2002 11:05:09 +1000
To: Corey Minyard <cminyard@mvista.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver for Linux, version 7
In-Reply-To: <649046018@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "Corey" == Corey Minyard <cminyard@mvista.com> writes:
Corey> Adrian Bunk wrote:

>> 
>> ...  Adopters Agreement:
>> 
>> Before implementing the IPMI, IPMB or ICMB specifications, a
>> royalty-free reciprocal patent license must be signed. Please
>> follow the steps below to sign the IPMI Adopters Agreement: ...  ·
>> Adopter hereby grants to the Promoters and to Fellow Adopters, and
>> the Promoters hereby grant to Adopter, a nonexclusive,
>> royalty-free, nontransferable, nonsublicenseable, worldwide license
>> under its Necessary Claims to make, have made, use, import, offer
>> to sell and sell products which comply with the Specification;
>> provided that such license shall not extend to features of a
>> product which are not required to comply with the Specification or
>> for which there exists a feasible, noninfringing alternative.  ...
>> 
>> <-- snip -->
>> 
>> 
>> Am I right that this makes it impossible to include an IPMI driver
>> into the kernel (this isn't GPL-compatible)?
>> 
Corey> I do not read it so, but perhaps you are right.  I will ask.
Corey> I'm sure I will receive a resounding "maybe" as the answer. 

I suspect the licence refers to the firmware bottom half, not the
driver to access it.

Peter C
