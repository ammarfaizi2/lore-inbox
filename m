Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTA3OZo>; Thu, 30 Jan 2003 09:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbTA3OZo>; Thu, 30 Jan 2003 09:25:44 -0500
Received: from [64.28.81.45] ([64.28.81.45]:266 "HELO
	mail.cumortgagecenter.com") by vger.kernel.org with SMTP
	id <S267510AbTA3OZn> convert rfc822-to-8bit; Thu, 30 Jan 2003 09:25:43 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Praveen Ray <praveen.ray@crcnet1.com>
Reply-To: praveen.ray@crcnet1.com
Organization: Compendium Research Corp
To: linux-kernel@vger.kernel.org
Subject: timer interrupts on HP machines
Date: Thu, 30 Jan 2003 09:34:54 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301300934.54201.praveen.ray@crcnet1.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have few HP (LPR NetServers and LT6000) which run 2.4.18  (from RedHat 8.0) 
. The problem is that sometimes the time interrupts stop coming - i.e. the 
(time) counts in /proc/interrupts stop getting incremented! When this 
happens, the date on the system falls behind, 'sleep' calls stop working and 
basically machine becomes unusable.Has anyone else encountered this problem? 
Is it an HP issue?
Thanks.
