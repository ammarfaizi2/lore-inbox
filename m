Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUFSKbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUFSKbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUFSKbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:31:11 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:53482 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265474AbUFSKbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:31:10 -0400
Message-Id: <5.1.0.14.2.20040619122933.00afee60@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 19 Jun 2004 12:32:32 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: wmb versus smp_wmb
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: SraeRUZGZeqJyCR+KrOaER-TcbEbnjdNpRuhNoq++LQiV+Q3FOhXol
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the $SUBJECT implies, when should one use
wmb() versus smp_wmb() ?
Thanks
Margit


