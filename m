Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264837AbRGCQaq>; Tue, 3 Jul 2001 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbRGCQag>; Tue, 3 Jul 2001 12:30:36 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:49150 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264837AbRGCQaW>; Tue, 3 Jul 2001 12:30:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-pre9: Failed HPT370 detection
Date: Tue, 3 Jul 2001 17:22:20 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070317222000.01180@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel refuses to detect my HPT370 chipset. (where my root filesystem 
is, on raid0). It just hangs where the detection usually takes place, so no 
oops and no meaningfull bugreport :/

I have the same options set in my config as I always have, I've never had any 
problem with this before. 

CONFIG_BLK_DEV_HPT366=y 
CONFIG_MD_RAID0=y

Anyone else seen this? Maybe its more VIA weirdness.


-- Regards, Gavin Baker
