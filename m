Return-Path: <linux-kernel-owner+w=401wt.eu-S1750741AbXAKQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXAKQE3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXAKQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:04:29 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:40251 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbXAKQE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:04:28 -0500
Message-Id: <20070111145115.405679742@delta.onse.fi>
User-Agent: quilt/0.45-1
Date: Thu, 11 Jan 2007 16:51:15 +0200
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 0/3] hid: series of patches for PantherLord USB/PS2 2in1 Adapter support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches fix PantherLord USB/PS2 2in1 Adapter support
so that it appears as two input devices, and add force feedback
support for it.

--
Anssi Hannula
