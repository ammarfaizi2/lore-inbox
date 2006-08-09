Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWHILgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWHILgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030703AbWHILgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:36:49 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:53153 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1030700AbWHILgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:36:48 -0400
Date: Wed, 9 Aug 2006 13:36:50 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Marvell PATA IDE Controller
Message-ID: <20060809113650.GA2959@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there a chance to get working Marvell PATA IDE Controller?

According to lspci it has 11ab:6101 ID.

If I add this ID into ahci.c, it finds one SATA port with no drive attached.

Actually, it has one PATA connector with DVD+RW attached to it.

In Windows XP, it is recognized as generic PCI IDE device.

-- 
Luká¹ Hejtmánek
