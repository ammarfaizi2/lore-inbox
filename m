Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSHMRWY>; Tue, 13 Aug 2002 13:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318970AbSHMRWX>; Tue, 13 Aug 2002 13:22:23 -0400
Received: from acd.ufrj.br ([146.164.3.7]:54277 "EHLO acd.ufrj.br")
	by vger.kernel.org with ESMTP id <S318972AbSHMRWC>;
	Tue, 13 Aug 2002 13:22:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Scorpion <scorpionlab@ieg.com.br>
Reply-To: scorpionlab@ieg.com.br
Organization: ScorpionLAB
To: linux-kernel@vger.kernel.org
Subject: Flush issues in boot phase
Date: Tue, 13 Aug 2002 14:25:19 -0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208131425.19328.scorpionlab@ieg.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi fellows,
I'm still trying to boot my dual AMD 1800XP machines (not MP).
I got one more step disabling MP 1.4 support on BIOS setup, but now
(using 2.4.19 kernel) I have a more general question.
The boot phase stop exactly with the message:

Partition check:
hda :

Should I consider that the kernel stop exactly in this point or
should I take in account any buffer problem,if yes shloud I
put a flush in any point, maybe a after printk statments?

Thank you in advance,
Scorpion.

Go Linux, go free!
