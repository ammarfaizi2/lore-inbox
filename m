Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbTELW3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbTELW3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:29:33 -0400
Received: from mail0.lsil.com ([147.145.40.20]:51857 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262858AbTELW3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:29:31 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F192@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Mukker, Atul" <Atulm@lsil.com>
Subject: unique entry points for all driver hosts
Date: Mon, 12 May 2003 18:41:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why doesn't mid-layer allow LLDs to specify separate entry points to various
hosts attached to the same driver. Like some other entries in the Scsi Host
Template, entry points should also  allowed to be overridden.


Thanks

-Atul Mukker
Storage Systems
LSI Logic Corporation
