Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270136AbTGUOYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbTGUOYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:24:52 -0400
Received: from sina187-143.sina.com.cn ([202.106.187.143]:60940 "HELO sina.com")
	by vger.kernel.org with SMTP id S270136AbTGUOYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:24:41 -0400
Message-ID: <3F1C6E9D.1080702@sina.com>
Date: Mon, 21 Jul 2003 22:52:13 +0000
From: snoopyzwe <snoopyzwe@sina.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20021130
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem of keyboard input and mouse movement
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I implemented a kernel thread, which runs every 1/5 HZ. My problem is
how to make the kernel thread know whether there is keyboard input or
mouse movement since last time it ran.
thanks



