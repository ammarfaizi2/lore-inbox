Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUDDOQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUDDOQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:16:03 -0400
Received: from adsl-212-101-16-178.solnet.ch ([212.101.16.178]:17262 "EHLO
	prometheus.ds9.ch") by vger.kernel.org with ESMTP id S262413AbUDDOQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:16:01 -0400
Date: Sun, 4 Apr 2004 16:16:00 +0200
From: Marcel Lanz <marcel.lanz@ds9.ch>
To: linux-kernel@vger.kernel.org
Subject: [PANIC] ohci1394 & copy large files
Message-ID: <20040404141600.GB10378@ds9.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.

Has anyone similar problems ?

Marcel
