Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPAya>; Fri, 15 Dec 2000 19:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbQLPAyK>; Fri, 15 Dec 2000 19:54:10 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:20744 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129319AbQLPAyF>;
	Fri, 15 Dec 2000 19:54:05 -0500
Date: Sat, 16 Dec 2000 02:23:41 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: pci_match_device question
Message-ID: <Pine.LNX.4.10.10012160219350.9778-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	why is pci_match_device supposed to return a _const_ struct
pci_device_id?What are the implications of defining it this way?
Is it just a contract or the compiler/linker does smt special with it if
its const?

Sorry if the second part of the question is a bit OT.

Jani

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
