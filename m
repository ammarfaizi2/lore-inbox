Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFCRpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTFCRpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 13:45:54 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:8081
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261188AbTFCRpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 13:45:53 -0400
Date: Tue, 3 Jun 2003 13:59:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Regarding SET_NETDEV_DEV
Message-ID: <20030603175921.GE2079@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For janitors and other developers placing this in net drivers...
please don't :)  This can be done in upper layers, accomplishing the
same goal without changing the low-level net driver code at all.

	Jeff




