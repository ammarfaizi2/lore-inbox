Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWDDWqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWDDWqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWDDWqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:46:32 -0400
Received: from 69.0.103.46.adsl.snet.net ([69.0.103.46]:57280 "EHLO
	Power-Mac-G5.local") by vger.kernel.org with ESMTP id S1750898AbWDDWqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:46:31 -0400
Date: Tue, 4 Apr 2006 18:46:31 -0400
From: Ron McCall <ronald.mccall@snet.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel for SBS VG5 SBC
Message-ID: <20060404224631.GA455@Power-Mac-G5.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does anyone happen to know if any stock Linux kernel can be configured
to run on SBS Technologies' VG5 Dual PowerPC VME Single Board Computer?
SBS says this board supports Linux but I can't find much info about this
at all.  The board is an asymmetric dual PowerPC 7455 or 7457 with a
Marvell MV64360 system controller.  I would be happy to use just one of
the processors.  I don't have the serial ATA option for the board so I
would need to netboot (and use an NFS root).  It has the PMON 2000 ROM
monitor on board.  A couple of hits on Google found a German web site
that looked like MontaVista might have had patches to support the VG5
with kernel 2.4.22 at some time but I can't seem to find any more about
it.  Just wondering whether anyone knew if this might be doable.  Thanks
in advance!

Ron McCall
