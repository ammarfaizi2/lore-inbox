Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbTHYQA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTHYQA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:00:58 -0400
Received: from dyn-ctb-210-9-243-120.webone.com.au ([210.9.243.120]:26897 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262024AbTHYQAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:00:23 -0400
Message-ID: <3F4A3293.8070004@cyberone.com.au>
Date: Tue, 26 Aug 2003 02:00:19 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] renicing X
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My scheduler patch really benefits a lot from renicing X. I
think its because it nices more nicely. Any reasons why this
might be a bad idea?



