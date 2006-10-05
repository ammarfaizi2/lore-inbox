Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWJEKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWJEKvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWJEKvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:51:06 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:35272 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751656AbWJEKvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:51:04 -0400
Date: Thu, 5 Oct 2006 12:52:50 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Machine reboot
Message-ID: <20061005105250.GI2923@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 147.251.54.96
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm facing troubles with machine restart. While sysrq-b restarts machine, reboot
command does not. Using printk I found that kernel does not hang and issues
reset properly but BIOS does not initiate boot sequence. Is there something
I could do?

-- 
Luká¹ Hejtmánek
