Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVA3SoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVA3SoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVA3SoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:44:06 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:34695 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261764AbVA3SoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:44:02 -0500
Date: Sun, 30 Jan 2005 19:44:01 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: IPMI smbus and Intel 6300ESB Watchdog drivers
Message-ID: <20050130184401.GC3373@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(third question to LKML today =)

I've recently bought an Intel SE7210TP1-E mainboard (specs here: 
http://www.intel.com/design/servers/boards/SE7210TP1-E/index.htm) and I 
now have most things working.

There are however, two questionmarks left.

1) On the mainboard is a 6300ESB Watchdog Timer (pci id 8086:25ab), but 
there seems to be no driver available for it. Does anyone know if there 
is any such driver in progress or if I've misunderstood the situation?

2) IPMI, Documentation/IPMI.txt mentions a ipmi_smb driver, but I could 
find no such driver in the 2.6.10 tree. Am I missing something?

Thanks in advance for any enlightenment.

Regards,
David Härdeman

Not subscribed...please CC me on any replies...
