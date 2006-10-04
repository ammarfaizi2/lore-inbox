Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030771AbWJDJHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771AbWJDJHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbWJDJHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:07:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33696 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030547AbWJDJHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:07:43 -0400
Message-ID: <452379D8.2040704@garzik.org>
Date: Wed, 04 Oct 2006 05:07:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Module warning in drivers/ide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'make allmodconfig' spits this out at the end of the build:

WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

