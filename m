Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTIQUfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTIQUfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:35:11 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:31659 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262752AbTIQUfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:35:07 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16232.50511.199563.3211@wombat.chubb.wattle.id.au>
Date: Thu, 18 Sep 2003 06:34:23 +1000
To: Jens Axboe <axboe@suse.de>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
In-Reply-To: <20030917075432.GG906@suse.de>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at>
	<20030914152755.GA27105@suse.de>
	<20030915093221.GE2268@gamma.logic.tuwien.ac.at>
	<20030917075432.GG906@suse.de>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:

Jens> On Mon, Sep 15 2003, Norbert Preining wrote:
>> On Son, 14 Sep 2003, Jens Axboe wrote: > > Will there be a new
>> incantation of the laptop-mode patch for 2.4.23-pre4
>> > 
>> > Sure, I'll done a new patch in the next few days. 

Are you thinking of pushing something like this into 2.6 as well?
I ask, because 2.6 seems to drive the laptop significantly harder than
2.4 anyway --- battery life is lower, the disk light is on more, and the
machine runs hotter.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
