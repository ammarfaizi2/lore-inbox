Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUEVH1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUEVH1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 03:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUEVH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 03:27:46 -0400
Received: from server112.anhosting.com ([205.243.144.10]:17902 "EHLO
	server112.anhosting.com") by vger.kernel.org with ESMTP
	id S264897AbUEVH1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 03:27:40 -0400
From: system <system@eluminoustechnologies.com>
To: linux-kernel@vger.kernel.org
Subject: hda Kernel error!!!
Date: Sat, 22 May 2004 12:57:28 +0530
User-Agent: KMail/1.5
Organization: eluminous technologies
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405221257.28570.system@eluminoustechnologies.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server112.anhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - eluminoustechnologies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
  When today I checked the server logs with logwatch I found under kernel 
section a very long messages about the kernel .
  I am usuall checking the logs daily,but I didn;t see the kernel sction so 
long before.
 In that I found warning about kernel error!!

WARNING:  Kernel Errors Present
   hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
   hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  1Time(s)

What is this error?
Dose this indicate error on hda?
Should I replace hda?OR it's different from all these?
Please help thank you...


