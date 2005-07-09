Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVGIOg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVGIOg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGIOg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:36:28 -0400
Received: from opersys.com ([64.40.108.71]:22028 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261428AbVGIOg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:36:26 -0400
Message-ID: <42CFE376.9040204@opersys.com>
Date: Sat, 09 Jul 2005 10:47:18 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: rol@witbe.net
CC: "'Kristian Benoit'" <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
References: <200507090901.j6991PD22890@tag.witbe.net>
In-Reply-To: <200507090901.j6991PD22890@tag.witbe.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Rolland wrote:
>>mmap           |     794us   |  654us (+18%)  |  822us (+4%)
>                                   ^^^^^^^^^^^^
> You mean -18%, not +18% I think.

Doh ... too many numbers flying around ... yes, -18% :)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
