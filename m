Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUHVCKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUHVCKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUHVCKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:10:44 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:2039 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S265222AbUHVCKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:10:40 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: <linux-kernel@vger.kernel.org>
Subject: Not to suppress NET kernel messages
Date: Sun, 22 Aug 2004 05:10:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSH9Zgr980NdAlHT2eb6aYFu1ExFA==
Message-Id: <S265222AbUHVCKk/20040822021040Z+1376@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the messages are rate limited by some code in network subsytem that
disallows a message from being sent to console for more than once. I am
trying to add some source debugging functions with printk, and I just wish
to disable this protection. 


