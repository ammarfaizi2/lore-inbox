Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbTIHQAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIHQAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:00:04 -0400
Received: from dyn-ctb-210-9-244-100.webone.com.au ([210.9.244.100]:50185 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262630AbTIHQAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:00:00 -0400
Message-ID: <3F5CA77E.6050104@cyberone.com.au>
Date: Tue, 09 Sep 2003 01:59:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler policy v14
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
kerneltrap gave me a more permanent place to host my patches.

http://www.kerneltrap.org/~npiggin/v14/

I'm starting to attack SMP and NUMA balancing, which is silly because I
only have a 2xSMP to test on (I'll try to get some NUMA time from OSDL).

I have provided rollups with and without the "core policy". Everything
else consists of cleanups and balancing changes, so its probably what
SMP/NUMA testers will want to use to start with.


