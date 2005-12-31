Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLaLlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLaLlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLaLlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:41:10 -0500
Received: from [202.67.154.148] ([202.67.154.148]:15018 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751078AbVLaLlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:41:08 -0500
Message-ID: <43B66E3D.2010900@ns666.com>
Date: Sat, 31 Dec 2005 12:40:45 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>	 <200512310027.47757.s0348365@sms.ed.ac.uk>	 <43B5D3ED.3080504@ns666.com>	 <200512310051.03603.s0348365@sms.ed.ac.uk>	 <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
In-Reply-To: <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
> 
>>g'morning !
>>
>>the memtest86 went 40 times over the memory, no errors detected.
>>
> 
> Give memtest86+ a spin (http://www.memtest.org/) as well. memtest86 is
> good, but I've found in the past that memtest86+ sometimes finds
> errors that memtest86 does not, so giving both a sin fo an extended
> period of time is usually a good idea.
> Also, make sure you enable all the tests of both tools.

Hi Jesper,

Oh i thought they were the same, i used memtest86+ which comes with
debian and not the "older" memtest86.

Right now i booted the kernel with nomce since one never knows with dell
machines as i saw on some redhat list. Furthermore i installed the
microcode32 utility which loaded new microcode in the cpu. So i'm now
going to continue put some good load on the system, tv on and so on, see
what happens.


