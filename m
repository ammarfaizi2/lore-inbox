Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAaLXK>; Wed, 31 Jan 2001 06:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRAaLXB>; Wed, 31 Jan 2001 06:23:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130153AbRAaLW4>; Wed, 31 Jan 2001 06:22:56 -0500
Subject: Re: hotmail not dealing with ECN
To: raj@cup.hp.com (Rick Jones)
Date: Wed, 31 Jan 2001 10:56:10 +0000 (GMT)
Cc: helgehaf@idb.hist.no (Helge Hafting), hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A71BC34.F8024103@cup.hp.com> from "Rick Jones" at Jan 26, 2001 10:04:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Nuvu-00027V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, no reason for a firewall author to check these bits.
> 
> I thought that most firewalls were supposed to be insanely paranoid.
> Perhaps it would be considered a possible covert data channel, as
> farfecthed as that may sound.

If you care about such things you run pure proxy. A packet filter is a simple
access barrier it isnt designed to stop information leakage

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
