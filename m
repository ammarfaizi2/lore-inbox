Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264049AbTDOTuT (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDOTuT 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:50:19 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:36224
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264049AbTDOTuT 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:50:19 -0400
To: linux-kernel@vger.kernel.org
Subject: DMA transfers in 2.5.67
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 22:01:28 +0200
Message-ID: <yw1x3ckjfs2v.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What do I need to do in a driver before doing DMA transfers to a PCI
card?  Using a driver that worked in 2.4 gives a throughput of only 10
MB/s in 2.5.67.  Is there some magic initialization that I have
missed?

-- 
Måns Rullgård
mru@users.sf.net
