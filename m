Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTIJEqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTIJEqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:46:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:9136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264526AbTIJEqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:46:44 -0400
Date: Tue, 9 Sep 2003 21:46:43 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309100446.h8A4khxh020463@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/hardware/eicon/divasmain.c:74: warning: data definition has no type or storage class
drivers/isdn/hardware/eicon/divasmain.c:74: warning: type defaults to `int' in declaration of `devfs_handle'
