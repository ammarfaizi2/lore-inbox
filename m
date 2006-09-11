Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWIKKNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWIKKNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWIKKNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:13:42 -0400
Received: from hermes.domdv.de ([193.102.202.1]:36358 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1751054AbWIKKNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:13:41 -0400
Message-ID: <450536D0.4020705@domdv.de>
Date: Mon, 11 Sep 2006 12:13:36 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Eric Sandall <eric@sandall.us>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz>
In-Reply-To: <20060907193333.GI8793@ucw.cz>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> See suspend.sf.net, use provided s2ram program.

Which,in my case (Acer Ferrari 4006), only works with "noapic" and
"radeon" not loaded.
Without "noapic" the system doesn't resume at all (same symptoms),
with "radeon" loaded the system resumes but locks up hard.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
