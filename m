Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLIPWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLIPWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLIPWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:22:37 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:36537 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932232AbVLIPWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:22:36 -0500
Date: Fri, 9 Dec 2005 16:22:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 update patches.
Message-ID: <20051209152230.GA6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
a bunch of s390 update patches. 4 bug-fix/cleanup patches, nothing
important. The other 13 patches introduce 6 new features:
 - dasd failfast support
 - oprofile callgraph support
 - hw-acceleration for in-kernel crypto sha256 & aes (4 patches)
 - qdio V=V pass-through
 - multiple subchannel sets support (5 patches)
 - cex2a crypto card support

All of it is 2.6.16 material.

blue skies,
  Martin.

