Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQLEPAa>; Tue, 5 Dec 2000 10:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbQLEPAU>; Tue, 5 Dec 2000 10:00:20 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:61515 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129765AbQLEPAL>; Tue, 5 Dec 2000 10:00:11 -0500
Date: Tue, 5 Dec 2000 16:29:18 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre19 SMP: LDT allocated for cloned task
Message-ID: <20001205162918.C1265@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these noteworthy: "LDT allocated for cloned task" (2.2.18pre19 SMP)? I
put an additional printk there to see which pid it is, and it is xmms.
The usage count mm->count is 3.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
