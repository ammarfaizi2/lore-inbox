Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUA1LPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUA1LPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:15:52 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:6075 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265908AbUA1LPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:15:52 -0500
Message-Id: <5.1.0.14.2.20040128120748.00a8f140@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 28 Jan 2004 12:16:38 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Firmware loader dependency question 2.4/2.6
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: TtqglgZr8ex+R2xdGOjY5lPkTB6kvgYopCBKPzzaKlN+XJyoHp5x0E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is the firmware loader dependent on CONFIG_HOTPLUG ?
For PCI cards that require this, it should not be necessary.

Margit


