Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTEaIvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTEaIvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:51:06 -0400
Received: from tag.witbe.net ([81.88.96.48]:3078 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264236AbTEaIvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:51:01 -0400
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: warning: process 'update' used the obsolete bdflush...
Date: Sat, 31 May 2003 11:04:20 +0200
Organization: Witbe.net
Message-ID: <006a01c32753$9fdac7b0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When switching from 2.4.20 to 2.5.x (x being recent), I have this
message...

What does this mean ?
1 - I have no process named update running,
2 - I can't find anything name update in /etc/rc.d/* recursively.

Regards,
Paul

