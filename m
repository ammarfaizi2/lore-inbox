Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQJ1Q02>; Sat, 28 Oct 2000 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQJ1Q0T>; Sat, 28 Oct 2000 12:26:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33552 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129481AbQJ1Q0L>; Sat, 28 Oct 2000 12:26:11 -0400
Subject: Re: PROBLEM: DELL PERC/Megaraid RAID driver in Linux 2.2.18pre17 hang
To: Daniel.Deimert@intermec.com
Date: Sat, 28 Oct 2000 17:27:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <E36790918FA6D411856500508BD3B2CA1A42@eusegotmail1b.eu.intermec.com> from "Daniel.Deimert@intermec.com" at Oct 28, 2000 09:15:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pYpR-0005QZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep - known problem. AMI have one more pre patch to sort it our Im going back
to the older driver 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
