Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVCOQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVCOQjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCOQjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:39:37 -0500
Received: from soapbox.yandex.ru ([213.180.200.36]:28139 "EHLO
	soapbox.yandex.ru") by vger.kernel.org with ESMTP id S261410AbVCOQjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:39:36 -0500
Date: Tue, 15 Mar 2005 19:39:17 +0300 (MSK)
From: "brndshmg" <brndshmg@yandex.ru>
Message-Id: <42370FB5.000017.30107@soapbox.yandex.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ]
To: linux-kernel@vger.kernel.org
Subject: JS20 reset problem
Reply-To: brndshmg@yandex.ru
X-Source-Ip: 212.69.121.67
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear list,

Anyone could help me with JS20 board?

I am working on an application which should work in HyperVisor mode
(I have a custom openfirmware which allows my application to work in HyperVisor mode).
Thus my application has to work with hardware directly, without using openfirmware.

Howerver I faced a problem when working on this application:

I can't reset a board.
I tried to reset a board via System Reset Register CF9 of AMD-8111 HT IO Hub, but the board hangs.
I think its possible to reset a board using watchdog timer, anyone tried to use this approacth?

Any ideas would be greatly appreciated.

Thanks,
Petr Krasinovsky
