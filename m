Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBBBwR>; Thu, 1 Feb 2001 20:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbRBBBv5>; Thu, 1 Feb 2001 20:51:57 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:3600
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129144AbRBBBvu>; Thu, 1 Feb 2001 20:51:50 -0500
Date: Thu, 1 Feb 2001 21:00:54 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: es1371 2.4.1 on noritake alpha
Message-ID: <20010201210054.A18651@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a sample of what I get:
es1371: sample rate converter timeout r = 0xeb970800
es1371: sample rate converter timeout r = 0x00870000
es1371: sample rate converter timeout r = 0x00970000
es1371: sample rate converter timeout r = 0xea800000

This card is on the secondary PCI bus.

System: AlphaServer 1000a 4/266

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
