Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTDWEWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 00:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTDWEWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 00:22:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:486 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263954AbTDWEWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 00:22:53 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Apr 2003 14:34:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16038.6105.580715.776682@wombat.disy.cse.unsw.edu.au>
CC: lbd@gelato.unsw.edu.au
Subject: Large block device support: new 2.4 patch; new mailing list
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I recently put up a new patch against 2.4.20 on our website at
http://www.gelato.unsw.edu.au/downloads

	As I no longer have access to larg emulti-terabyte block
devices to test with (nor indeed as much time as I'd need), I thought
it'd be worth trying to put people that do have such equipment in
touch with each other.  So I've created a mailing list. 

As I personally *hate* being subscribed to lists I didn't know about,
I haven't subscribed anybody except myself to the list...  You can
subscribe yourselves at

	 http://www.gelato.unsw.edu.au/mailman/listinfo/lbd

or by sending an email containing the word `subscribe' to
lbd-request@gelato.unsw.edu.au


	I'm intending to cc: all further answers to queries about LBD to that
list so that the questions and answers will be archived, and
googleable, and so that common information can be shared more easily.

	This email has been sent BCC to all the people who've sent
email queries to me about large block device support in the last few
weeks, as well as to the kernel mailing list.

--
Dr Peter Chubb     http://www.gelato.unsw.edu.au  peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

