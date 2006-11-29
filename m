Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967180AbWK2MtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967180AbWK2MtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967177AbWK2MtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:49:17 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:59789 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757680AbWK2Ms6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:48:58 -0500
Date: Wed, 29 Nov 2006 13:49:24 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch -mm 0/2] s390: Updates for dynamic subchannel mapping.
Message-ID: <20061129134924.2262f3ca@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following two patches (against 2.6.19-rc6-mm2) contain updates for
the s390 common I/O layer on top of
s390-dynamic-subchannel-mapping-of-ccw-devices.patch.

[1/2] s390: Use dev->groups for subchannel attributes.
[2/2] s390: Update cio documentation.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
