Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTKLXqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKLXqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:46:32 -0500
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:6293 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261807AbTKLXqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:46:31 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16306.50739.124983.506831@wombat.chubb.wattle.id.au>
Date: Thu, 13 Nov 2003 10:45:55 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@colin2.muc.de>, Peter Chubb <peter@chubb.wattle.id.au>,
       Andi Kleen <ak@muc.de>,
       Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
In-Reply-To: <3FB214F2.2020806@namesys.com>
References: <QugF.3Mq.7@gated-at.bofh.it>
	<Qwit.771.11@gated-at.bofh.it>
	<QR40.39P.53@gated-at.bofh.it>
	<m3d6bybeiw.fsf@averell.firstfloor.org>
	<16306.35809.15450.378197@wombat.chubb.wattle.id.au>
	<20031112222609.GA2924@colin2.muc.de>
	<3FB214F2.2020806@namesys.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hans" == Hans Reiser <reiser@namesys.com> writes:

Hans> Andi Kleen wrote:
>>> Has the kmalloc problem in Reiserfs gone away?  It used to be that
>>> the limit for a Reiser filesystem was determined by how many
>>> pointers could fit into a kmalloced chunk of memory;
>>> 
Hans> ?  I am not familiar with this....

http://www.ussg.iu.edu/hypermail/linux/kernel/0207.0/0678.html

Peter C
