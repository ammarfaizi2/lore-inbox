Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbRETTq2>; Sun, 20 May 2001 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbRETTqS>; Sun, 20 May 2001 15:46:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14602 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262187AbRETTqB>; Sun, 20 May 2001 15:46:01 -0400
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 20 May 2001 20:41:49 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), froese@gmx.de (Edgar Toernig),
        bcrl@redhat.com (Ben LaHaise), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <3B0717CE.57613D4A@mandrakesoft.com> from "Jeff Garzik" at May 19, 2001 09:03:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151Z5J-0002mK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are LVM and EVMS(competing LVM project) needed at all?

I prefer to think of it the other way around

> Surely the same can be accomplished with
> * md
> * snapshot blkdev (attached in previous e-mail)
> * giving partitions and blkdevs the ability to grow and shrink
> * giving filesystems the ability to grow and shrink

How about 'partitions are in inferior legacy form of LVM'

