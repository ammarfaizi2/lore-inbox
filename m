Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbQLGCIE>; Wed, 6 Dec 2000 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbQLGCHo>; Wed, 6 Dec 2000 21:07:44 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:2311
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S130030AbQLGCHi>; Wed, 6 Dec 2000 21:07:38 -0500
Date: Wed, 6 Dec 2000 20:47:23 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre6 on alpha
Message-ID: <20001206204723.A8390@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm glad to say that this is the first 2.4 kernel that works on my noritake
alpha with a pci-pci bridge.

I have a small problem.  If I reboot, the srm console can't boot from dka0.
Doing a: show dev
doesn't list any of the hard drives in the machine.
doing an init causes it to reset and find all the drives again.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
