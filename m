Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRAVXzR>; Mon, 22 Jan 2001 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRAVXzI>; Mon, 22 Jan 2001 18:55:08 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:12548
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S130238AbRAVXyv>; Mon, 22 Jan 2001 18:54:51 -0500
Date: Mon, 22 Jan 2001 19:03:22 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: cardbus nic modules
Message-ID: <20010122190322.A5058@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed, everytime I use a cardbus card, pcmcia-cs uses the name of the
driver instead of eth0 (or eth1).

If I need to upgrade pcmcia-cs, that's fine, but it appears to be a bug.

pcmcia-cs version: 3.1.20 (debian v2)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
