Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUHVVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUHVVJL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUHVVJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:09:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266128AbUHVVJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:09:08 -0400
Message-ID: <41290B69.5020107@pobox.com>
Date: Sun, 22 Aug 2004 17:08:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>
CC: ftpadmin@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: BK snapshot process updated
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, by updated, I mean fixed.  :)

For 2.4, nightly BK snapshots are being generated once again at
http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/

For 2.6, I fixed a bug that caused the script to break whenever the 
version number format changes (even from 2.6.8-rc1 to 2.6.8 required 
manual invention).  Nightly BK snapshots are being generated at the 
familiar location,
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/

The snapshot version is always $kversion-bk$snapshot

	Jeff


