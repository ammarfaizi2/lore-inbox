Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUG0XsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUG0XsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUG0XsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:48:13 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:693 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S266732AbUG0XsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:48:11 -0400
Message-ID: <4106EA88.10707@am.sony.com>
Date: Tue, 27 Jul 2004 16:51:36 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Roger Luethi <rl@hellgate.ch>, Robert Wisniewski <bob@watson.ibm.com>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
       richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: LTT user input
References: <16640.10183.983546.626298@tut.ibm.com> <20040723100101.GA22440@k3.hellgate.ch> <16641.19483.708016.320557@tut.ibm.com> <20040723191900.GA2817@k3.hellgate.ch> <16641.36290.751769.126111@k42.watson.ibm.com> <20040723234502.GA12631@k3.hellgate.ch> <410410F9.5030403@opersys.com>
In-Reply-To: <410410F9.5030403@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Plus, I've run into a ton of people who have told me that this type of
> tool is essential for their day-to-day work. I will stop short of
> covering actual names, but you should hear about such things in the near
> future.

Sony has used LTT in the past, and we plan to use it for a few more
development projects underway currently.  It would be nice if we
didn't have to wait for all the pieces to fall together for each
new kernel release (arch support, trace point patches, desired
sub-system stability).  Having seen LTT used for a number of years,
I'd have to agree with Karim's assessment that it would probably
be "neater" today if so much time hadn't been spent over the
years wrangling it into the kernel.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
