Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVAEOrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVAEOrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVAEOrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:47:48 -0500
Received: from math.ut.ee ([193.40.5.125]:64396 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262266AbVAEOr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:47:28 -0500
Date: Wed, 5 Jan 2005 16:47:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI init error messages
Message-ID: <Pine.SOC.4.61.0501051646080.8230@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.10+todays BK on Intel D815EEA2 mainboard. It seems to work 
fine so far but gives these messages on bootup:

ACPI: Subsystem revision 20041210
     ACPI-1138: *** Error: Method execution failed [\MCTH] (Node c14deea0), AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c14ded00), AE_AML_BUFFER_LIMIT

-- 
Meelis Roos (mroos@linux.ee)
