Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbUDGE3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 00:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbUDGE3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 00:29:54 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:13976 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264092AbUDGE3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 00:29:53 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16499.33689.920494.448577@wombat.chubb.wattle.id.au>
Date: Wed, 7 Apr 2004 14:29:13 +1000
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: <58907794@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Horst" == Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>> The only one is that performance would suffer because of use of
>> higher level language than C or Assembler.

Horst> Because the performance and size of kernel code is _critical_,
Horst> maybe?  Because much of the kernel code has been carefully
Horst> tuned for maximum performance perhaps?

>> There is a reason people use languages like PERL, Java and so on.

Horst> And there are solid reasons for _not_ writing operating system
Horst> kernels in them too...

Hey, why not just port Xemacs to run on the bare metal.  That way you
get a lisp interpreter `for free'.  :-)
--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*


