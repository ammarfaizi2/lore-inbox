Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUHQUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUHQUYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUHQUXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:23:06 -0400
Received: from mail.siemenscom.com ([12.146.131.10]:62104 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S268412AbUHQUW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:22:29 -0400
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F320@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <jack.bloch@siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Bonding driver 
Date: Tue, 17 Aug 2004 13:22:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.4.19 Kernel from SuSE running the bonding driver. I can see that
the bonding driver is switching over to the standby bonded interface for no
"apparent" reason. I have a couple of questions.

Namely,

Are there any patches to the bonding driver?

What would cause a bonded interface to be switched over?

I am also seeing duplex packets being caused by this. Is this known
behavior?


Please CC me directly on any response.


Regards,


Jack
