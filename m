Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVJCFw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVJCFw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJCFw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:52:57 -0400
Received: from [211.152.52.46] ([211.152.52.46]:59800 "HELO mail.kingsoft.net")
	by vger.kernel.org with SMTP id S932143AbVJCFw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:52:57 -0400
Message-ID: <003c01c5c7de$63716490$6515a8c0@antivirus.rdev.kingsoft.net>
From: "liixixi" <avlimeng@kingsoft.net>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: pthread question
Date: Mon, 3 Oct 2005 13:50:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
    I have a question in using pthread_join, when I program in windows, I
can call WaitForSingleObject to wait another thread exit, I can pass a
time-out to WaitForSingleObject, but, with pthread_join, I can't do the same
thing like WaitForSingleObject, any ideas? thx.
            liixixi

