Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130343AbQK1Xxc>; Tue, 28 Nov 2000 18:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130138AbQK1XxM>; Tue, 28 Nov 2000 18:53:12 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:54284 "EHLO
        enterprise.cistron.net") by vger.kernel.org with ESMTP
        id <S129780AbQK1XxC>; Tue, 28 Nov 2000 18:53:02 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
Date: 28 Nov 2000 23:23:01 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <901eol$3es$1@enterprise.cistron.net>
In-Reply-To: <20001128222040.H2680@sith.mimuw.edu.pl> <E140slT-000565-00@the-village.bc.nu> <20001128231334.A438@var.cx>
X-Trace: enterprise.cistron.net 975453781 3548 195.64.65.201 (28 Nov 2000 23:23:01 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001128231334.A438@var.cx>,
Frank v Waveren  <fvw@var.cx> wrote:
>On Tue, Nov 28, 2000 at 09:58:14PM +0000, Alan Cox wrote:
>> > Because you want to be able to `kill <pid>`?
>> > And if you are over-limits you can't?
>> Wrong. limit is a shell built in
>
>I assume you mean kill is a shell builtin. Depending on your shell. :-).

No. Think about it.

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
