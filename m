Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbQKFDrt>; Sun, 5 Nov 2000 22:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbQKFDrj>; Sun, 5 Nov 2000 22:47:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14526 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130138AbQKFDr2>;
	Sun, 5 Nov 2000 22:47:28 -0500
Date: Sun, 5 Nov 2000 19:32:08 -0800
Message-Id: <200011060332.TAA22764@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: phil@fifi.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <87snp7gmzl.fsf@tantale.fifi.org> (message from Philippe Troin on
	04 Nov 2000 18:40:30 -0800)
Subject: Re: 2.2.x BUG & PATCH: recvmsg() does not check msg_controllen correctly
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org>
 <200011032218.OAA12790@pizda.ninka.net> <878zr0vbda.fsf@tantale.fifi.org>
 <200011040038.QAA13178@pizda.ninka.net> <87u29oz93z.fsf@tantale.fifi.org>
 <200011040451.UAA13833@pizda.ninka.net> <87snp7gmzl.fsf@tantale.fifi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Philippe Troin <phil@fifi.org>
   Date: 04 Nov 2000 18:40:30 -0800

   How about this one ?

Yep, this works, applied.

Please send plain-ASCII patches in the future though :-(

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
