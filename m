Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbTGPOF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270849AbTGPOF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:05:57 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:27342 "EHLO
	mail.lysator.liu.se") by vger.kernel.org with ESMTP id S270846AbTGPOFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:05:52 -0400
User-Agent: IMHO/0.98.3 (Webmail for Roxen)
Date: Wed, 16 Jul 2003 16:20:42 +0200
MIME-Version: 1.0
From: Magnus Ekhall <koma@lysator.liu.se>
To: linux-kernel@vger.kernel.org
Subject: PCI logger
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030716142043.0DDB69528D@mail.lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to get the kernel to log the accesses it does to the
PCI bus, perhaps even for a specific device?

I'd like to use this as a means to debug a device driver...

Cheers,
Magnus
