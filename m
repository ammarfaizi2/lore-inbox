Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVDURl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDURl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDURl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:41:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48267 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261580AbVDURk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:40:26 -0400
Date: Thu, 21 Apr 2005 10:39:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc3 compile error in aic7xxx_osm.c
Message-ID: <779170000.1114105182@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_init':
drivers/scsi/aic7xxx/aic7xxx_osm.c:3608: parse error before `int'
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: `rc' undeclared (first use in this function)
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: (Each undeclared identifier is reported only once
drivers/scsi/aic7xxx/aic7xxx_osm.c:3609: for each function it appears in.)
drivers/scsi/aic7xxx/aic7xxx_osm.c: At top level:
drivers/scsi/aic7xxx/aic7xxx_osm.c:744: warning: `ahc_linux_detect' defined but not used


