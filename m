Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUA0AiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265597AbUA0AiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:38:07 -0500
Received: from main.gmane.org ([80.91.224.249]:34449 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265631AbUA0Ah5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:37:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: Re: [net/8139cp] still crashes my notebook
Date: Tue, 27 Jan 2004 01:09:44 +0100
Message-ID: <slrnc1bb28.bb5.andreashappe@flatline.ath.cx>
References: <slrnc104io.mp.andreashappe@flatline.ath.cx> <87vfn24kgn.fsf@devron.myhome.or.jp> <1074959508.13666.4.camel@Athlon1.hemma.se> <87brot3un2.fsf@devron.myhome.or.jp>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-24, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> Thomas Svedberg <thsv@am.chalmers.se> writes:
>> I can confirm that this patch fixes the same complete lockup I have had
>> since 2.6.0-test4 or so, (See: "Hard lock with recent 2.6.0-test
>> kernels").
>> 
>> Tested against 2.6.2-rc1-mm2 which locks har without patch and works
>> great with it.
>
> Thaks for testing.

I just wanted to confirm that this patch has solved my problem (my
computer hasn't crashed with 8139cp since ~48h).

Thanks for the patch,
Andreas

