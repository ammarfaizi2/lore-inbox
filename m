Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbRDVTZl>; Sun, 22 Apr 2001 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135252AbRDVTZb>; Sun, 22 Apr 2001 15:25:31 -0400
Received: from cnxt10143.conexant.com ([198.62.10.143]:49673 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135249AbRDVTZZ>; Sun, 22 Apr 2001 15:25:25 -0400
Date: Sun, 22 Apr 2001 21:25:16 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>, <pcmcia-cs-devel@lists.sourceforge.net>,
        <dhinds@zen.stanford.edu>
Subject: ide-cs module name mismatch.
Message-ID: <Pine.LNX.4.33.0104222117540.1417-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm using kernel-2.4.3 and pcmcia-cs-3.1.25.

The kernel module is called ide-cs while the pcmcia-cs package
looks for ide_cs. I'm not sure which should be corrected...

Rui Sousa

