Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272485AbTHAVoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTHAVoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:44:14 -0400
Received: from mail0.lsil.com ([147.145.40.20]:57581 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S272431AbTHAVoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:44:13 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F3DD@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@Dell.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: [ANNOUNCE]: MegaRAID linux driver version 1.18j
Date: Fri, 1 Aug 2003 17:43:59 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MegaRAID driver version 1.18j has been released. This driver solves a buffer
overflow error when /proc/megaraid/X/stat file is read with many logical
drives configured and IOs going on over a period of time.

The location to download the driver is:
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-1.18j/

Atul Mukker
Storage Systems
LSI Logic Corporation
