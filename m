Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSIBJMs>; Mon, 2 Sep 2002 05:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318246AbSIBJMr>; Mon, 2 Sep 2002 05:12:47 -0400
Received: from mx1.mail.ru ([194.67.57.11]:16138 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id <S318243AbSIBJMr>;
	Mon, 2 Sep 2002 05:12:47 -0400
Date: Mon, 2 Sep 2002 13:09:38 +0400
From: Molbo <molbo@inbox.ru>
X-Mailer: The Bat! (v1.53) UNREG / CD5BF9353B3B7091
Reply-To: Molbo <molbo@inbox.ru>
X-Priority: 3 (Normal)
Message-ID: <882173015.20020902130938@inbox.ru>
To: linux-kernel@vger.kernel.org
Subject: how get dentry cache to swap
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if I try to create on tmpfs 100k nodes, this kills all my free 25Mb
Ram.
question is can be dentry cache made swap cachable


