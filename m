Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbRAWLSW>; Tue, 23 Jan 2001 06:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbRAWLSN>; Tue, 23 Jan 2001 06:18:13 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:13306 "HELO
	dark.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S130085AbRAWLSD>; Tue, 23 Jan 2001 06:18:03 -0500
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <m3g0iaxzr6.fsf@giants.mandrakesoft.com>
	<Pine.LNX.4.21.0101231044220.1386-100000@penguin.homenet>
	<3A6D6602.BCA969E2@uow.edu.au>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 23 Jan 2001 12:18:11 +0000
In-Reply-To: <3A6D6602.BCA969E2@uow.edu.au>
Message-ID: <m3y9w2a2d8.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.95
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <andrewm@uow.edu.au> writes:

> As far as the klogd problem is concerned, see
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0101.1/1053.html
> 
> for a probable solution.

it look like it fixes the problem for me, thanks.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
