Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288716AbSAVH3A>; Tue, 22 Jan 2002 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289182AbSAVH2t>; Tue, 22 Jan 2002 02:28:49 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:50560 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S288716AbSAVH2n>;
	Tue, 22 Jan 2002 02:28:43 -0500
Message-ID: <3C4D149A.8080703@pobox.com>
Date: Mon, 21 Jan 2002 23:28:26 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020117
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dieter =?ISO-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: rwhron@earthlink.net, Robert Love <rml@tech9.net>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114165430.421B01ED55@Cantor.suse.de> <20020114182019.E22791@athlon.random> <20020122051248Z288255-13996+9603@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

>But you should bench 2.4.18pre2aa2 + preempt + lock-break or
>2.4.18-pre4 + O(1) J4 + 10_vm-22 (aa2) + preempt + lock-break...
>
>That's what I'm doing all night long for Robert...
>

In that case, will you also do plain 2.4.18pre2-aa2?

The effects of O(1), preempt etc on -aa2 would of
course only be meaningful when compared to
vanilla -aa2 on the same platform.

I will be doing testing here with 2.4.18-pre4-aa1.

Regards,

Joe



