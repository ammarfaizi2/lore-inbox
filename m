Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbUCRWRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUCRWRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:17:08 -0500
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:1744 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263212AbUCRWQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:16:57 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16474.8079.179369.536317@wombat.chubb.wattle.id.au>
Date: Fri, 19 Mar 2004 09:15:43 +1100
To: John Bradford <john@grabjohn.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Remove kernel features (for embedded systems)
In-Reply-To: <369036857@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Bradford <john@grabjohn.com> writes:

>> And if it is at all possible, I would like to be able to remove
>> parts of the IP stack, e.g. routing.  In particular, I would like
>> to be able to remove policy routing, if it is at all worth it from
>> the code size point of view.

John> Why not just write your own IP stack in userspace, if you're
John> doing a heavily embedded system?


You mean, like http://www.sics.se/~adam/lwip/ ??

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
