Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270269AbRHWUOs>; Thu, 23 Aug 2001 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270270AbRHWUOm>; Thu, 23 Aug 2001 16:14:42 -0400
Received: from trained-monkey.org ([209.217.122.11]:42512 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S270263AbRHWUOb>; Thu, 23 Aug 2001 16:14:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: releasing driver to kernel in source+binary format
In-Reply-To: <E15ZzmR-0004O1-00@the-village.bc.nu>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 23 Aug 2001 16:14:38 -0400
In-Reply-To: Alan Cox's message of "Thu, 23 Aug 2001 20:04:39 +0100 (BST)"
Message-ID: <m3vgjelej5.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Well, Qlogic also has their firmware released in binary format.
Alan> Firmware that runs on the processor in the card is somewhat of a
Alan> different item. If its just a binary firmware image to load into
Alan> the card and that is run by the card I dont think its an issue.

Alan> If its code run on the host processor then there is an issue.

One might even want to add that opening up firmware has some positive
side effects: Look at how Alteon completely ruled the Gigabit Ethernet
world with their NIC and open firmware programme (until they decided
to bug out before the big players started picking up and squeezing
them out on price).

Jes
