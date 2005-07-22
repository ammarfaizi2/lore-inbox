Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVGVEqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVGVEqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVGVEqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:46:34 -0400
Received: from [203.76.137.4] ([203.76.137.4]:56725 "EHLO globaledgesoft.com")
	by vger.kernel.org with ESMTP id S262008AbVGVEqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:46:33 -0400
Message-ID: <42E079B8.9070703@globaledgesoft.com>
Date: Fri, 22 Jul 2005 10:14:40 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Boyer <jdub@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: why is jiffies 128 in jffs2_find_gc_block() in gc.c of jffs2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thak you very much.

I am not clear why the hardcoded values are 50, 110 and 126
and why is jiffies moded with 128, why not any other value.

Regards,
Krishna Chaitanya
