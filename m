Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272428AbRIKMgh>; Tue, 11 Sep 2001 08:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272429AbRIKMg0>; Tue, 11 Sep 2001 08:36:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272428AbRIKMgT>; Tue, 11 Sep 2001 08:36:19 -0400
Subject: Re: 2.4.10pre7aa1
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 11 Sep 2001 13:40:37 +0100 (BST)
Cc: dipankar@in.ibm.com (Dipankar Sarma), hch@caldera.de,
        linux-kernel@vger.kernel.org, paul.mckenney@us.ibm.com (Paul Mckenney)
In-Reply-To: <20010911130430.L715@athlon.random> from "Andrea Arcangeli" at Sep 11, 2001 01:04:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15gmqD-0002YK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, I fixed a few more issues in the rcu patch (grep for
> down_interruptible for instance), here an updated patch (will be
> included in 2.4.10pre8aa1 [or later -aa]) with the name of rcu-2.

I've been made aware of one other isue with the RCU patch
US Patent #05442758

In the absence of an actual real signed header paper patent use grant for GPL 
usage from the Sequent folks that seems to be rather hard to fix.

Alan
