Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWEAPdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWEAPdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWEAPdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:33:44 -0400
Received: from [84.204.75.166] ([84.204.75.166]:54963 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932131AbWEAPdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:33:43 -0400
Message-ID: <44562A53.7090705@oktetlabs.ru>
Date: Mon, 01 May 2006 19:33:39 +0400
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> What about task_t vs struct task_struct? Both are used in the kernel.

If you use task_struct's fields, pick struct task_struct, otherwise pick 
task_t.

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
