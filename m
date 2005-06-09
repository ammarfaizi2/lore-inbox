Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVFIBYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVFIBYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVFIBYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:24:16 -0400
Received: from easyspace.ezspl.net ([216.74.109.141]:6539 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S261556AbVFIBYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:24:13 -0400
Message-ID: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
Date: Wed, 08 Jun 2005 21:24:25 -0400
From: kallol@nucleodyne.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Performance figure for sx8 driver
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - easyspace.ezspl.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - nucleodyne.com
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/horde/imp/compose.php 
X-Source-Dir: :/base/horde/imp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have performace figure for sx8 driver which is for promise SATAII150
8 port PCI-X adapter?

Someone reports that on a platform with sx8 driver, multiple hdparms on
different disks those are connected to the same adapter (there are 8 ports) can
not get more than 45MB/sec in total, whereas a SCSI based driver for the same
adapter gets around 150MB/sec.

Any comment on this?


Kallol Biswas
www.nucleodyne.com
kallol@nucleodyne.com
