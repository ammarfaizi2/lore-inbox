Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbUAZKig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUAZKig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:38:36 -0500
Received: from [218.5.74.208] ([218.5.74.208]:50144 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S265577AbUAZKia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:38:30 -0500
Message-ID: <4014EE22.9070902@lovecn.org>
Date: Mon, 26 Jan 2004 18:38:26 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: tao@debian.org
CC: linux-kernel@vger.kernel.org
Subject: [2.0.39] drivers/char/baycom.c Zero Sized File
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David

I downloaded 2.0.39 from kernel.org, and find that the file 
drivers/char/baycom.c is a zero sized.
Also see this http://lxr.linux.no/source/drivers/char/baycom.c?v=2.0.39

Only Documentation/magic-number.txt describes:

BAYCOM_MAGIC        0x3105bac0  struct baycom_state  drivers/char/baycom.c


also thanks to Segher Boessenkool


Coywolf Q. Hunt

