Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWEOIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWEOIuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWEOIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:50:14 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14113 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750991AbWEOIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:50:12 -0400
Date: Mon, 15 May 2006 10:50:11 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org, greg@kroah.com
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: [PATCH 0/2] Hypervisor Filesystem for s390
Message-Id: <20060515105011.5a639592.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Greg,

As discussed, I send you again the complete
patch series for the s390 hypervisor filesystem.

There are two patches:
1/2: common code: create /sys/hypervisor if needed
2/2: s390: s390_hypfs filesystem

Michael


