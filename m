Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSKERHY>; Tue, 5 Nov 2002 12:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSKERHX>; Tue, 5 Nov 2002 12:07:23 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:27795 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S264950AbSKERHL>; Tue, 5 Nov 2002 12:07:11 -0500
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: When laptop is docked, eth0 moves from pcmcia to docking station nic (both work wth same driver)
Date: Tue, 5 Nov 2002 09:17:30 -0800
Message-ID: <002601c284ef$395ef5d0$0472e50c@peecee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
 
I don't know exactly where to look to solve this problem, so im posting
here.
 
I have a laptop with a 3com PCMCIA NIC and a 3com NIC built into a
docking station. When I dock my laptop, eth0 becomes the docking station
NIC. I just want to know where to look to be able to control which
device becomes which device. Im used to Solaris where a path_to_inst
file correlates a device path to an instance number and device links are
made accordingly. Does Linux have a similar capability?
 
I wouldn't care so much about this, but vmware acts flaky if you have a
bridge on both eth0 and eth1 when eth1 disappears.
 
Thanks in advance,
 
--Buddy


