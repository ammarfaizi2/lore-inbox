Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUBIQU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBIQU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:20:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:8323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265213AbUBIQU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:20:26 -0500
From: john cherry <cherry@osdl.org>
Date: Mon, 9 Feb 2004 08:20:24 -0800
Message-Id: <200402091620.i19GKOG26060@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc1 - 2004-02-08.17.30) - 1 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/qla2xxx/qla_iocb.c:356: warning: `sg' might be used uninitialized in this function
