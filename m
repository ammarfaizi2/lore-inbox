Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDWF7w>; Mon, 23 Apr 2001 01:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRDWF7n>; Mon, 23 Apr 2001 01:59:43 -0400
Received: from [159.226.41.188] ([159.226.41.188]:49168 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S131307AbRDWF7h>; Mon, 23 Apr 2001 01:59:37 -0400
Date: Mon, 23 Apr 2001 13:59:52 +0800
From: "Xiong Zhao" <xz@gatekeeper.ncic.ac.cn>
To: majordomo linux kernel list <linux-kernel@vger.kernel.org>
Subject: how does linux support domino?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <77457B80127E.AAA4AA2@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.on linux we will see a new domino server process/thread is created for each
client.how does linux do this?does it use pthread?using fork or clone or someway 
else?what's the common way of linux to support apps like lotus domino that will
have lots of concurrent users which are served by seperate server process/thread?
regards

james

