Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273972AbRIXQC4>; Mon, 24 Sep 2001 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273973AbRIXQCr>; Mon, 24 Sep 2001 12:02:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273968AbRIXQCf>; Mon, 24 Sep 2001 12:02:35 -0400
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Mon, 24 Sep 2001 17:08:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20010924174745.A8230@emma1.emma.line.org> from "Matthias Andree" at Sep 24, 2001 05:47:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lYHC-0002zc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Those drives should be blacklisted and rejected as soon as someone tries
> to mount those pieces rw. Either the drive can make guarantees when a
> write to permanent storage has COMPLETED (either by switching off the
> cache or by a flush operation) or it belongs ripped out of the boxes and
> stuffed down the throat of the idiot who built it.

In which case you can choose between ancient ST-506 drives and SCSI

Alan
