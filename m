Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUBYUnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUBYUnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:43:05 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:50705 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261437AbUBYUlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:41:47 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.3-mm3: mark_info_dirty needs export
Date: Wed, 25 Feb 2004 23:26:46 +0300
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402252326.46794.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.6.3-mm3/kernel/fs/quota_v2.ko needs unknown symbol 
mark_info_dirty
make: Leaving directory `/home/bor/src/linux-2.6.3-mm3'

-andrey
