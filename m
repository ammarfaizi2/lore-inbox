Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbRETUNj>; Sun, 20 May 2001 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbRETUN3>; Sun, 20 May 2001 16:13:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262210AbRETUNM>; Sun, 20 May 2001 16:13:12 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 20 May 2001 21:07:52 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rmk@arm.linux.org.uk (Russell King),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        matthew@wil.cx (Matthew Wilcox), alan@lxorguk.ukuu.org.uk (Alan Cox),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105201512450.8940-100000@weyl.math.psu.edu> from "Alexander Viro" at May 20, 2001 03:42:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151ZUW-0002pg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about sprintf(s + strlen(s), foo)?

Solar Designer said two years ago we should be using snprintf in the kernel.
He was most decidedly right 8)
