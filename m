Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSBSMoy>; Tue, 19 Feb 2002 07:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291378AbSBSMod>; Tue, 19 Feb 2002 07:44:33 -0500
Received: from f15.pav0.hotmail.com ([64.4.33.86]:47373 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291372AbSBSMo2>;
	Tue, 19 Feb 2002 07:44:28 -0500
X-Originating-IP: [202.88.231.6]
From: "blesson paul" <blessonpaul@msn.com>
To: linux-kernel@vger.kernel.org
Subject: loading modules
Date: Tue, 19 Feb 2002 18:14:22 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F15LuSbh29cM3oryKFR00012514@hotmail.com>
X-OriginalArrivalTime: 19 Feb 2002 12:44:22.0424 (UTC) FILETIME=[27C4C980:01C1B943]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
		I am a newbie  to Kernel world. When I looked into the file system files, 
I found that the initialization function ( where the file system is 
registered) is “init_filesystem”  where filesystem can be coda, vfat etc. As 
far as know, the initialization function is
	int init_module(void)
		Then how kernel takes different initialization functions. I want to know 
whether my know how is wrong or not

Thanking in advance
regards
Blesson Paul





_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

