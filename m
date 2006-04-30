Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWD3VuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWD3VuH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWD3VuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:50:07 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:57516 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751226AbWD3VuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:50:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17493.12438.286201.810702@wombat.chubb.wattle.id.au>
Date: Mon, 1 May 2006 07:48:06 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <1146391189.10561.157.camel@shinybook.infradead.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	<1146105458.2885.37.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	<1146107871.2885.60.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	<20060427213754.GU3570@stusta.de>
	<Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
	<17492.34204.844839.262357@wombat.chubb.wattle.id.au>
	<1146391189.10561.157.camel@shinybook.infradead.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

David> On Sun, 2006-04-30 at 19:38 +1000, Peter Chubb wrote:
>> So now we need something new.

David> No we don't. 

I meant, we can no longer use /usr/include/sys.  In the early days of
linux, we used /usr/include/{linux,asm}, but that was stopped for good
reasons.  FWIW, I think your cleanups are a step in the right direction.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
