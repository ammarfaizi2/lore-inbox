Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTIKOgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTIKOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:35:00 -0400
Received: from dyn-ctb-203-221-74-143.webone.com.au ([203.221.74.143]:38663
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261306AbTIKOev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:34:51 -0400
Message-ID: <3F608807.9090705@cyberone.com.au>
Date: Fri, 12 Sep 2003 00:34:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler policy v15
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
http://www.kerneltrap.org/~npiggin/v15/

This was going to get high res timers, but instead fixed a bug that might
be causing a few people oopses. Also very small interactivity tweaks.

I'm starting to work on SMP and NUMA ideas now, so if any interactivity
things are bothering you, please tell me soon. I should be getting access
to a 32-way NUMA soon, so I'm sort of holding off chaning too much until
then.

Enjoy.


