Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266930AbTGTLXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266931AbTGTLXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:23:39 -0400
Received: from helios.univ-reunion.fr ([194.199.73.1]:42201 "EHLO
	helios.univ-reunion.fr") by vger.kernel.org with ESMTP
	id S266930AbTGTLXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:23:37 -0400
Message-ID: <3F1A7D4E.5010503@univ-reunion.fr>
Date: Sun, 20 Jul 2003 15:30:22 +0400
From: Alain BASTIDE <alain.bastide@univ-reunion.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.2.1) Gecko/20030225
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0 ac2 3c905C 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

	My ethernet card doesn't accept nfs + compile kernel !!!!
	I'm got a MSI 6501 AMD MP 2000+!!!!!!

	How i can do????

Thanks
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:04.0: 3Com PCI 3c905C Tornado at 0xb000. Vers LK1.1.19



eth0: Resetting the Tx ring pointer.
nfsd: last server has exited
nfsd: unexporting all filesystems
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
diagnostics: net 0ccc media 8c80 dma 000000a0 fifo 8000
Flags; bus-master 1, dirty 214461(13) current 214477(13)
Transmit list 37df8a20 vs. f7df8a20.
0: @f7df8200  length a75a29bf status 82ae1bbf
1: @f7df82a0  length a63d4dbf status 26543bbf
2: @f7df8340  length 0b2662bf status 6cf359bf
3: @f7df83e0  length bf8506bf status 46d6ffbe
4: @f7df8480  length 00000022 status 000105ea
5: @f7df8520  length 00000022 status 000005ea
6: @f7df85c0  length 00000022 status 000005ea
7: @f7df8660  length 00000022 status 000005ea
8: @f7df8700  length 00000022 status 000003c2
9: @f7df87a0  length 0000002a status 000005ea
10: @f7df8840  length 00000022 status 000005ea
11: @f7df88e0  length 00000022 status 800005ea
12: @f7df8980  length 00000022 status 800005ea
13: @f7df8a20  length 6fe517bd status 32d9bf3d
14: @f7df8ac0  length 88341d3b status 4f77babc
15: @f7df8b60  length 1e09c43d status 2785b63d




