Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287321AbSACPPM>; Thu, 3 Jan 2002 10:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287325AbSACPPD>; Thu, 3 Jan 2002 10:15:03 -0500
Received: from web14913.mail.yahoo.com ([216.136.225.240]:2318 "HELO
	web14913.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287322AbSACPOu>; Thu, 3 Jan 2002 10:14:50 -0500
Message-ID: <20020103151449.83445.qmail@web14913.mail.yahoo.com>
Date: Thu, 3 Jan 2002 10:14:49 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: About the Raw device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, there is an front-end raw character
devices in Linux kernel 2.4.  It can be bound to any
block devices to provide genuine Unix raw character
device semantics. Does that mean that this device can
intercept the communications to/from the specific
block device? It seems not. I've tested that on floppy
disk device. Is that true? Can anyone give me an
example of how to test this raw character device?
Thanks in advance.

Michael

______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
