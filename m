Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTIHXQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTIHXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:16:00 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:2984
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263772AbTIHXP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:15:57 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16221.3496.796304.383173@wombat.chubb.wattle.id.au>
Date: Tue, 9 Sep 2003 09:15:52 +1000
To: scott_list@mischko.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Plans for better performance metrics in upcoming kernels?
In-Reply-To: <200309080754.55700.scott_list@mischko.com>
References: <200309051641.44228.scott_list@mischko.com>
	<200309080754.55700.scott_list@mischko.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Scott" == Scott Chapman <scott_list@mischko.com> writes:

Scott> Hi all, I received one reply to this email.  I take it there is
Scott> nobody really heading up the implementation of improved/missing
Scott> performance metrics in the kernel?


I've been working on microstate acounting, and am interested in better
metrics overall, for capacity planning and for accounting.

I think that SGI also have been doing some work -- see
http://oss.sgi.com/projects/csa/ 

Peter C
