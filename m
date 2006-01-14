Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWANWnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWANWnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWANWnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:43:37 -0500
Received: from smtp08.web.de ([217.72.192.226]:60055 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S1751331AbWANWng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:43:36 -0500
Subject: 2.6.15-g87530db5:TPM unknown symbols
From: Thomas Meyer <thomas.mey@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 14 Jan 2006 23:40:30 +0100
Message-Id: <1137278431.32156.2.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.6.15-g87530db5/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_create_dir
WARNING: /lib/modules/2.6.15-g87530db5/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_remove
WARNING: /lib/modules/2.6.15-g87530db5/kernel/drivers/char/tpm/tpm_bios.ko needs unknown symbol securityfs_create_file

does anybody care?

kind regards
Thomas


