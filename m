Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130181AbQKFEM4>; Sun, 5 Nov 2000 23:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130185AbQKFEMq>; Sun, 5 Nov 2000 23:12:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37054 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130181AbQKFEMd>;
	Sun, 5 Nov 2000 23:12:33 -0500
Date: Sun, 5 Nov 2000 19:57:10 -0800
Message-Id: <200011060357.TAA22904@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: phil@fifi.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <87vgu1spzo.fsf@tantale.fifi.org> (message from Philippe Troin on
	05 Nov 2000 20:07:07 -0800)
Subject: Re: 2.2.x BUG & PATCH: recvmsg() does not check msg_controllen correctly
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org>
 <200011032218.OAA12790@pizda.ninka.net> <878zr0vbda.fsf@tantale.fifi.org>
 <200011040038.QAA13178@pizda.ninka.net> <87u29oz93z.fsf@tantale.fifi.org>
 <200011040451.UAA13833@pizda.ninka.net> <87snp7gmzl.fsf@tantale.fifi.org>
 <200011060332.TAA22764@pizda.ninka.net> <87vgu1spzo.fsf@tantale.fifi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Philippe Troin <phil@fifi.org>
   Date: 05 Nov 2000 20:07:07 -0800

   "David S. Miller" <davem@redhat.com> writes:

   > Yep, this works, applied.

   I assume this will go in 2.2.18 right ? Alan ?

It has been sent to Alan already for inclusion.

   Did 2.4.x exhibit the same problem ?

Yes, patch queued for when Linus makes a the next pre-patch.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
