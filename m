Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUEBTyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUEBTyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUEBTyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 15:54:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:60903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263226AbUEBTyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 15:54:13 -0400
X-Authenticated: #20450766
Date: Sun, 2 May 2004 21:54:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org, <postmaster@vger.kernel.org>
Subject: hda active and hdb sleep?
Message-ID: <Pine.LNX.4.44.0405022150410.4526-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The message below never made it to LKML. This time CC-ing the "postmaster"
- in case it fails again.

Thanks
Guennadi
---
Guennadi Liakhovetski


---------- Forwarded message ----------
Date: Wed, 28 Apr 2004 20:15:44 +0200 (CEST)
From: Guennadi Liakhovetski <lyakh@poirot.grange>
To: linux-kernel@vger.kernel.org
Subject: hda active and hdb sleep?

Hello

As soon as I issue hdparm -Y /dev/hdb I get errors on hda and it doesn't
seem to be possible to have hdb in sleep and hfa active. I think, those
power-states are purely per-device, aren't they. It's a VIA ProSavage
KM133 chipset. 2.6.3 kernel at the moment.

Thanks
Guennadi
---
Guennadi Liakhovetski



