Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUF0MsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUF0MsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 08:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUF0MsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 08:48:13 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:17559 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262382AbUF0MsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 08:48:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Somebody filtered BK traffic from kernel.bkbits.net
Date: Sun, 27 Jun 2004 14:45:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.27.12.45.37.541240@smurf.noris.de>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1088340337 4354 192.109.102.35 (27 Jun 2004 12:45:37 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 27 Jun 2004 12:45:37 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pulling from kernel.bkbits.net is currently somewhat impossible:

$ netstat -t
tcp     0      1 kiste.smurf.noris:37668 kernel.bkbits.net:14690 SYN_SENT

Port 80 works fine... so apparently somebody over-tightened some
firewall's screws.

-- 
Matthias Urlichs
