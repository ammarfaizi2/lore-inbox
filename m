Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUKRR2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUKRR2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUKRR2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:28:44 -0500
Received: from mail.convergence.de ([212.227.36.84]:51362 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262794AbUKRRQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:16:40 -0500
Message-ID: <419CD8BC.1080401@linuxtv.org>
Date: Thu, 18 Nov 2004 18:15:40 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Andrew Morton <akpm@osdl.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Hunold <hunold@convergence.de>
Subject: Re: Fw: Re: Linux 2.6.10-rc2 [dvb-bt8xx unload oops]
References: <20041116014350.54500549.akpm@osdl.org> <20041118130312.GE19568@bytesex>
In-Reply-To: <20041118130312.GE19568@bytesex>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.11.2004 14:03, Gerd Knorr wrote:
>>This is vanilla 2.6.10-rc2 on P4. This was a problem with -rc1 but

> Yes, looks very simliar ...

>>some patches off the list [attached] fixed it. I expected these to be
>>in -rc2, I am not able to say which patch is missing.

> Uhm, strange.  The bttv patches _are_ merged.
> Not sure about any for dvb-bt8xx, Michael?

Hm, I'm not sure either, because Eyal says that the problem does not 
exist with rc2-mm1. But AFAIK all DVB stuff has been merged by Linus so 
I'm clueless here... 8-(

>   Gerd

CU
Michael.

