Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSK1IQ5>; Thu, 28 Nov 2002 03:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSK1IQ5>; Thu, 28 Nov 2002 03:16:57 -0500
Received: from [217.6.75.131] ([217.6.75.131]:8647 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S265247AbSK1IQ5>; Thu, 28 Nov 2002 03:16:57 -0500
Message-ID: <3DE5D2AD.72686009@inw.de>
Date: Thu, 28 Nov 2002 00:24:14 -0800
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Q] Which kernel + special patches ???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

following this list for quite a while now raised the above question.  To get
more specific:
Given an SMP system with many thousand processes and a potentially high network
and IO load, what is the best combination of source and patch, to make best use
of SMP, keep load low and throughput high?

Is it 2.4.x + rmap or aa or O(1) or ac or some combination
OR ist it 2.5.x + one (or more) of the above patches ???

Many thanks for the help and Happy Thanksgiving!

Immanuel

