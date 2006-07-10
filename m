Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161319AbWGJD1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWGJD1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWGJD1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:27:06 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:10130 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1161319AbWGJD1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:27:05 -0400
Message-ID: <20060710132702.zybmjie9co8wk440@www.rexursive.com>
Date: Mon, 10 Jul 2006 13:27:02 +1000
From: Bojan Smojver <bojan@rexursive.com>
To: linux-kernel@vger.kernel.org
Subject: Intel ICH7 82801GBM/GHM
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know if this chip, which goes by PCI ID 8086:27c4 (as  
listed in ata_piix.c) is something that ahci.c can also drive? It  
isn't listed explicity in ahci.c file, but ata_piix.c file says it's  
identical to ICH6M, which is listed in ahci.c.

PS. I'm not subscribed to the list, so please CC me on the answer.

TIA,
-- 
Bojan
