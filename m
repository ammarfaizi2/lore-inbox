Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265624AbUFDHyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbUFDHyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 03:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFDHyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 03:54:50 -0400
Received: from hosted-by.rockingstone.nl ([213.206.77.161]:38293 "EHLO
	web1.rockingstone.nl") by vger.kernel.org with ESMTP
	id S265624AbUFDHyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 03:54:49 -0400
Date: Fri, 4 Jun 2004 09:54:48 +0200
From: Rick Jansen <rick@rockingstone.nl>
To: linux-kernel@vger.kernel.org
Subject: DriveReady SeekComplete Error
Message-ID: <20040604075448.GK18885@web1.rockingstone.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Sysadmin-was-here: Rick Jansen (Rockingstone IT)
X-PGP-Key: http://www.rockingstone.nl/rick/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this drive fubar? It's installed brand-new, and after only three days
of operating it's giving me these errors from time to time.

May 30 07:08:18 web3 kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
May 30 07:08:18 web3 kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=227270012, sector=227270007
May 30 07:08:18 web3 kernel: end_request: I/O error, dev hda, sector
227270007

I could find some other people on the net with these problems, but none
of them happened with brandnew drives. 

What can I do?

Rick Jansen

-- 
Looking for books? Try http://www.megabooksearch.com
The Linux on 64-Bit platforms Wiki: http://www.linux64.net
PGP Public Key: http://www.rockingstone.nl/rick/pubkey.asc
