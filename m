Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRD1G1x>; Sat, 28 Apr 2001 02:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRD1G1m>; Sat, 28 Apr 2001 02:27:42 -0400
Received: from f50.law7.hotmail.com ([216.33.237.50]:11792 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S132413AbRD1G1h>;
	Sat, 28 Apr 2001 02:27:37 -0400
X-Originating-IP: [63.227.107.196]
From: "daniel sheltraw" <l5gibson@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: busmaster question
Date: Sat, 28 Apr 2001 01:27:30 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F50IEAOeIiGXix4A2Dr00010c13@hotmail.com>
X-OriginalArrivalTime: 28 Apr 2001 06:27:31.0191 (UTC) FILETIME=[4DBCB070:01C0CFAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel listees

I have a busmaster question I am hoping you can help me with.
If a PCI device is acting as a busmaster and the processor initiates a 
read/write to another device on the PCI bus while the busmater-device is in 
control of the bus what happens to the instructions initiated by the 
processor? Are they never seen by the device that the processor
is trying to read/write?

Thanks for helping me with this,
Daniel
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

