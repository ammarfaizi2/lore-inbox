Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUEBXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUEBXlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 19:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEBXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 19:41:42 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:8584 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263366AbUEBXll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 19:41:41 -0400
Date: Mon, 3 May 2004 00:41:21 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6 and diskless swap (nbd? nfs?)
Message-ID: <Pine.LNX.4.58.0405030037490.22749@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just curious, what is one supposed to do for swap for diskless 
machines? Swap on NFS files refuses to work. Is swap on NBD possible 
(googling suggests patches were required - did these make it in to 
the kernel?). If not, is there any way at all to sanely do swap for 
diskless machines with 2.6?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
HAL 9000: Dave. Put down those Windows disks, Dave. DAVE! 
