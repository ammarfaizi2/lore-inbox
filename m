Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129606AbRBBBS0>; Thu, 1 Feb 2001 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbRBBBSQ>; Thu, 1 Feb 2001 20:18:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130427AbRBBBSI>;
	Thu, 1 Feb 2001 20:18:08 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.2646.764648.559351@pizda.ninka.net>
Date: Thu, 1 Feb 2001 17:16:06 -0800 (PST)
To: kuznet@ms2.inr.ac.ru
Cc: alan@lxorguk.UKuu.ORG.UK (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: AF_UNIX hangs
In-Reply-To: <200102011949.WAA21764@ms2.inr.ac.ru>
In-Reply-To: <E14OOp7-0004rR-00@the-village.bc.nu>
	<200102011949.WAA21764@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > Yep... Damn, specially split errno and ready values and forgot to use
 > this. 8) Sorry.

Patch applied.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
