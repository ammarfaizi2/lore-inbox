Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTIMNUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTIMNUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:20:02 -0400
Received: from dyn-ctb-203-221-73-70.webone.com.au ([203.221.73.70]:10756 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262150AbTIMNUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:20:00 -0400
Message-ID: <3F63197D.2000306@cyberone.com.au>
Date: Sat, 13 Sep 2003 23:19:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: KConfig help text not shown in 2.6.0-test5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test5, the help text for choice options (eg. processor type,
highmem) is not shown in either menuconfig or oldconfig. It does work
in gconfig, however. Don't know when it last worked.


