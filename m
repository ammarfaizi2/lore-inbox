Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129229AbRBSKdR>; Mon, 19 Feb 2001 05:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRBSKdG>; Mon, 19 Feb 2001 05:33:06 -0500
Received: from t2.redhat.com ([199.183.24.243]:19182 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129229AbRBSKcx>; Mon, 19 Feb 2001 05:32:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1010219040821.16489E-100000@mandrakesoft.mandrakesoft.com> 
In-Reply-To: <Pine.LNX.3.96.1010219040821.16489E-100000@mandrakesoft.mandrakesoft.com> 
To: Philipp Rumpf <prumpf@mandrakesoft.com>
Cc: Kenn Humborg <kenn@linux.ie>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        akpm <andrewm@uow.edu.au>
Subject: Re: kernel_thread() & thread starting 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Feb 2001 10:32:35 +0000
Message-ID: <25350.982578755@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


prumpf@mandrakesoft.com said:
>  Why bother ?  It looks like a leftover debugging message which
> doesn't make a lot of sense once the code is stable (what might make
> sense is checking keventd is still around, but that's not what the
> code is doing).

> Proposed patch:

>  dwmw2 ? 

Don't look at me. I didn't like the current_is_keventd stuff very much 
in the first place. akpm?

--
dwmw2


