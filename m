Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKVMbH>; Wed, 22 Nov 2000 07:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQKVMa6>; Wed, 22 Nov 2000 07:30:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54112 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129851AbQKVMaw>; Wed, 22 Nov 2000 07:30:52 -0500
Subject: Re: ECN causing problems
To: mrwizard@psu.edu (Joseph Gooch)
Date: Wed, 22 Nov 2000 12:00:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws> from "Joseph Gooch" at Nov 21, 2000 10:26:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yYZz-0005sd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My RaptorNT 6.5 firewall rejects all connections from my linux box when ECN
> is enabled.  The error is attached.  Perhaps this feature should be disabled
> by default?  Or is there already an option of the sort that i'm missing?  I
> only got the idea to disable it after a search of linux-kernel.

Your raptorNT 6.5 firewall is faulty, its as simple as that. Check if they have
an upgrade to fix their error.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
