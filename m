Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267072AbUBMQnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267114AbUBMQnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:43:23 -0500
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:29070 "EHLO
	mail.jg555.com") by vger.kernel.org with ESMTP id S267072AbUBMQnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:43:22 -0500
Message-ID: <04f701c3f250$6bc11fb0$d300a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>, der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
References: <1oMkR-1Zk-21@gated-at.bofh.it> <E1ArfAQ-00007f-7Z@localhost>
Subject: Re: Initrd Question
Date: Fri, 13 Feb 2004 08:42:50 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So is the /proc/real-root-dev seems to be a necessary file after all for the
pivot_root to work, is that correct? If so the initrd.txt needs to be
updated.

