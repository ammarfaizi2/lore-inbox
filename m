Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULPIWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULPIWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbULPIWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:22:54 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52421 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261840AbULPIWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:22:53 -0500
Date: Thu, 16 Dec 2004 09:22:25 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Gerald Schaefer <geraldsc@de.ibm.com>
Subject: [patch 0/2] s390: z/VM monreader + watchdog driver bugfixes
Message-ID: <20041216082225.GA5043@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

these two patches are for -bk and it would be good to have them in
2.6.10. Without these patches our z/VM watchdog doesn't work at all,
and there would be a potential security problem with the z/VM
monreader driver.

Thanks,
Heiko
