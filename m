Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTFASdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbTFASdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:33:24 -0400
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:12996 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S264700AbTFASdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:33:23 -0400
Message-ID: <000501c3286e$62d1b510$17010101@hal>
From: "Gutko" <gutko@poczta.onet.pl>
To: <linux-kernel@vger.kernel.org>
Subject: What is wrong  with modules in 2.5.69-70 ?
Date: Sun, 1 Jun 2003 20:48:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
What is wrong  with modules in 2.5.69-70 generally. Every option I compile
as module does not work because modprobe says on boot "couldn't load module
xxxxx". If I compile it in (*) then works ok. In 2.4.x modules works ok for
me.
I've updated all "boot" programs to versions mentioned in
/Documentation/Changes
Mandrake 9.1


