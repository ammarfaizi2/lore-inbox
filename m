Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUCaNSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCaNSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:18:00 -0500
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:30439 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261723AbUCaNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:17:58 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 31 Mar 2004 15:16:36 +0200
MIME-Version: 1.0
Subject: 2.4.21 on Itanium2: floating-point assist fault at ip 400000000062ada1, isr 0000020000000008
Reply-to: ulrich.windl@rz.uni-regensburg.de
Message-ID: <406AE0D5.10359.1930261@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.77+2.18+2.07.040+05 January 2004+87296@20040331.130955Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did try to find an answer is SuSE's support database, not in SAP's support 
database, and also did search Google, but could not find an answer:

We run SuSE Linux Enterprise Server 8 (SLES8) on a HP rx4640 Itanium2 server 
with 2 CPUs (family: Itanium 2, model: 1, revision: 5, archrev: 0).

In syslog is do see periodic kernel messages (with no implicit priority) that 
read:

dw.sapC11_DVS02(14393): floating-point assist fault at ip 400000000062ada1, 
isr 0000020000000008

("dw.sapC11_DVS02" is a SAP R/3 work process (46D_EXT, patch 1754, for those 
who care)

Can anybody explain what this message means? Is it an application problem, or 
is it a kernel problem?

Regards,
Ulrich
P.S. I'm not subscribed to linux-kernel, so please CC: at least.

