Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUFTHkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUFTHkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 03:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUFTHkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 03:40:55 -0400
Received: from imap.gmx.net ([213.165.64.20]:21957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264954AbUFTHky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 03:40:54 -0400
X-Authenticated: #4512188
Message-ID: <40D53F7E.6010509@gmx.de>
Date: Sun, 20 Jun 2004 09:40:46 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.7-ck1, cfq ionice?
References: <200406162122.51430.kernel@kolivas.org> <40D4A962.7030508@gmx.de> <40D4C9AA.5030307@kolivas.org>
In-Reply-To: <40D4C9AA.5030307@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Prakash K. Cheemplavam wrote:
> | The only thing left, which is a major pain for me, is disk i/o. Once it
> | starts performance goes down, I think even more with staircase than with
> | Nick's but this could be due to faster feel of staircase in general...
> |
> | As I understood the cfq ionice part would solve this issue. I never
> By default -ck1 uses the default I/O scheduler which is anticipatory.
> You can set the cfq scheduler (as I recommend and write in my faq) by
> adding the boot command:
> 
> elevator=cfq

I have forgotten to mention it, but I am already using cfq io scheduler...

> Hopefully Jens will resync his ionice work with the current cfq
> scheduler. As soon as he does I'll include it in -ck ;-)

Great. :-)

bye,

Praaksh
