Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTAaJl2>; Fri, 31 Jan 2003 04:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267742AbTAaJl2>; Fri, 31 Jan 2003 04:41:28 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:53043 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267741AbTAaJl1>; Fri, 31 Jan 2003 04:41:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Bisping <rbisping@mindspring.com>
Reply-To: rbisping@mindspring.com
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: yenta-cardbus IRQ0
Date: Fri, 31 Jan 2003 04:45:13 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18eXoy-0000iL-00@tisch.mail.mindspring.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have been trying to set up a cardbus card on my thinkpad 760ED for about 
the last month and it keeps coming up with IRQ0 and telling me it cant find a 
irq for pin A. what would be causing this and how do I correct it i have 
already tried APCI and it does not work on my laptop so that is no help. I 
have compiled SMP into the kernel though I dont have a dual processor (of 
course) to gain the added functionality. I have recompiled my kernel about 
150 times with different setting hoping it might just be a conflict in the 
kernel with no luck.  I looked at the yenta driver it's self and noticed that 
it accepts IRQ0 as a valid irq but that appears to mean no irq at all. which 
config file would i use to force it to set a irq?


Thanx for any assistanc you might give


