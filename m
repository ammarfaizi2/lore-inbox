Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTD2DM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 23:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTD2DM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 23:12:29 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:46721 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S261780AbTD2DM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 23:12:28 -0400
From: root@mauve.demon.co.uk
Message-Id: <200304290324.EAA04296@mauve.demon.co.uk>
Subject: BTTV problems 2.4.20
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2003 04:24:43 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hauppage BT848 card with the stock kernel driver seems to occasionally 
after reboot (warm, or poweroff under a few seconds) continue to write to
memory.
It's not the motherboard or RAM (changed from a PPRO 240, to a Duron 1300
with different RAM).
When this happens with the first motherboard, it failed POST (sometimes) 
and memtest would reveal memory errors in the top few meg of RAM.
(16-40Mb of RAM installed) 

On the second motherboard, it unfortunately got past POST once, and 
proceeded to shred a filesystem when checking it.
Any thoughts?
