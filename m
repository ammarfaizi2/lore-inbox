Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280167AbRKNGSj>; Wed, 14 Nov 2001 01:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280171AbRKNGS3>; Wed, 14 Nov 2001 01:18:29 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:4111 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280167AbRKNGSY>;
	Wed, 14 Nov 2001 01:18:24 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111140618.fAE6II9122454@saturn.cs.uml.edu>
Subject: Re: 2.4.x has finally made it!
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Wed, 14 Nov 2001 01:18:18 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011113171836.A14967@emma1.emma.line.org> from "Matthias Andree" at Nov 13, 2001 05:18:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree writes:
> On Tue, 13 Nov 2001, Alastair Stevens wrote:

>> For those who haven't seen it yet, Moshe Bar at BYTE.com has revisited his
>> Linux 2.4 vs FreeBSD benchmarks, using 2.4.12 in this case:
>>
>>  http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html
>
> Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
> is just as good as piping it to /dev/null. See RFC-1123.

The same could be said of any mail server that isn't RAID at
the very least. Oh, let's demand an off-site backup before
returning an OK status to the sender, and one of those S/390
processors that runs two pipelines in lock-step to detect
errors in the CPU. Swat the very last kernel bug too BTW.

Really, this isn't a big deal. Maybe it wasn't the best choice.
The drive probably lies to the OS anyway, so get over it.
