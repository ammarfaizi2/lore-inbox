Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVKCXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVKCXDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKCXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:03:51 -0500
Received: from pop-cowbird.atl.sa.earthlink.net ([207.69.195.68]:2488 "EHLO
	pop-cowbird.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751300AbVKCXDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:03:51 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14: advansys & zd1201 on PowerMac 8500/G3
Message-Id: <E1EXo7K-0003hp-4O@penngrove.fdns.net>
Date: Thu, 03 Nov 2005 15:03:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got mixed results with new kernel on PowerMac 8500/G3.  Given a
couple of my earlier patches for previous releases, my Advansys SCSI 
card is finally showing signs working under 2.6!

Alas, i can't really test it adequately (hence no patch posted) as my
wireless USB dongle (ZD1201) doesn't come up reliably after rebooting
and seems to hang up randomly under interactive use.  Unplugging and
then re-plugging it brings it back up, but i can't leave it that way as
the machine also acts as a server.  I've not looked at this carefully
yet, and will post more when i have a better understanding of what
might be going wrong with this device.
					-- JM
