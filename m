Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJIG1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 02:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTJIG1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 02:27:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:28138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTJIG1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 02:27:32 -0400
Date: Wed, 8 Oct 2003 23:27:31 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310090627.h996RVN0021822@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test7 - 2003-10-08.18.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/atm/fore200e.c:1074: warning: unused variable `i'
