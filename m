Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTF1KZz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 06:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTF1KZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 06:25:55 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:23982 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265142AbTF1KZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 06:25:55 -0400
Message-Id: <5.1.0.14.2.20030628123855.00aefd18@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 28 Jun 2003 12:40:36 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.22-pre2 unresolved proc_get_inode
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: r2M-AeZbwewCx3RiFnYgj8KCHiXIfBpB+ZYYpQ9SbZ9O1h3409vVrT@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre2; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-pre2/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

I suppose we let Christoph and Marc fight it out.

Margit

