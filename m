Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTDTRaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTDTRaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:30:03 -0400
Received: from tag.witbe.net ([81.88.96.48]:47623 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263643AbTDTRaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:30:03 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Subject: Shutting down kernel 2.5.6x... and devices...
Date: Sun, 20 Apr 2003 19:42:03 +0200
Message-ID: <004301c30764$27c4f890$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Each time I try to shutdown my machine now running kernel 2.5.68,
I have messages stating :
unregister_netdevice: waiting for tap0 to become free. Usage count = 2

for ever, and the machine doesn't stop/halt/restart.

Trying to kill the process using tap0 is not enough, it seems to
be "unkillable"... (it is the tool named vtund).

What is this ? It is perfect with 2.4.x

Regards,
Paul

