Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJRMuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 08:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTJRMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 08:50:18 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:30988 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261567AbTJRMuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 08:50:15 -0400
Message-ID: <3F913704.5040707@cyberone.com.au>
Date: Sat, 18 Oct 2003 22:50:12 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v16
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

http://www.kerneltrap.org/~npiggin/v16/

I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
a bit. It isn't too bad, although I'm only testing dbench, tbench, and
volanomark at the moment.

These SMP and NUMA changes are not tied to my interactivity stuff, so its
possible they could get included if they turn out well. If you find any
problems with it (high end or interactivity), please let me know.



