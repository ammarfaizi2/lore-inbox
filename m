Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUEDAIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUEDAIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUEDAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:08:42 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:16579 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S264026AbUEDAIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:08:39 -0400
Message-ID: <4096E173.2070305@am.sony.com>
Date: Mon, 03 May 2004 17:18:59 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] delete "POSIX conformance testing by UNIFIX" message
References: <20040503160347.088af84e.rddunlap@osdl.org>
In-Reply-To: <20040503160347.088af84e.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> // linux-266-rc3
> // delete the POSIX UNIFIX conformance testing message;
> 
> There is a general desire to reduce the quantity of noisy and/or
> outdated kernel boot-time messages...
 >
> Other comments?

I've always been bothered by this message.  It's meaningless
at best, incorrect at worst, and wasteful of screen
real-estate and output time on bootup.

It's a small fix, but very welcome.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

