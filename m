Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUL1IZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUL1IZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUL1IZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:25:43 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:50063 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261763AbUL1IZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:25:39 -0500
Date: Tue, 28 Dec 2004 09:24:04 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] s390: updates for -bk
Message-ID: <20041228082404.GA7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

since Martin is still not back I'm sending you a bunch of s390
patches:

1/8: core patches
2/8: Common I/O layer patches
3/8: Network device driver patches
4/8: DASD driver patches
5/8: character device driver patches
6/8: DCSS cleanup fix
7/8: new DCSS SHM device driver
8/8: SCLP device driver cleanup

Thanks,
Heiko
