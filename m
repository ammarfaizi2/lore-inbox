Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTGUMoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbTGUMoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:44:08 -0400
Received: from sina187-156.sina.com.cn ([202.106.187.156]:19717 "HELO sina.com")
	by vger.kernel.org with SMTP id S269981AbTGUMoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:44:07 -0400
Message-ID: <3F1C570E.8080607@sina.com>
Date: Mon, 21 Jul 2003 21:11:42 +0000
From: snoopyzwe <snoopyzwe@sina.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20021130
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to calculate the system idle time
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to implement a module, whose main task is to check the system
idle time(no keyboard and mouse input) and suspend the whole system(when
the idle time is long enough). But there comes the problem, how to
calculate the system idle time. How can I get the time user has no
operation.
thanks
snoopyzwe



