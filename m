Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310391AbSCBPot>; Sat, 2 Mar 2002 10:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310396AbSCBPoa>; Sat, 2 Mar 2002 10:44:30 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:3945 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310391AbSCBPoZ>; Sat, 2 Mar 2002 10:44:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: "Henrik Lassen" <henrik@lassen.dk>
Subject: Re: Please
Date: Sat, 2 Mar 2002 16:43:58 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <NCBBLCAMGIICAAEFKIENIEOECDAA.henrik@lassen.dk>
In-Reply-To: <NCBBLCAMGIICAAEFKIENIEOECDAA.henrik@lassen.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ataraid-list@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020302154358.D025F13E3@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 2. March 2002 00:27, Henrik Lassen wrote:
> Hi
>
> I saw your posting Promise TX4 - I bought two controllers (shit).

Confirmed.

> Using: Redhat 7.2 Egnima Kernel 2.4.7-10
>
> I can se the first two disk, but redhat crashes if I try to connect the
> others.

The problem is called Andre Hedrick, a guy who is talking in miracles,
but seems to be unable to fix either the issues with:
 - the single TX4 with multiple PDC20270
nor:
 - multiple TX2 with PDC20268

or at least ignores further communication on that problems, if you
don't use some magic storage peoples language.(*) TM in a parallel 
universe, not too far from here...

Most other kernel guys prefer SCSI or simple IDE solutions.

> Please tell how you got IDE3-4 working and if you are up and running
> satisfactory.

Nope. In one board, I got two TX2 running fine. In different other
boards (tyan thunder dual athlon), only a single TX2 is working fine.
(System crashed shortly after IDE driver init in above mentioned 
combinations.

BTW: This is a 2 way communication problem: 
 - Andre ignores bugging user requests to some extend
 - He gets ignored by leading kernel hackers to some extend

both based on (*) 

One can only hope, that Andre gets his bablefish running, and
using it then to communicate with the rest of _this_ universe. 

>
> Rgds
>
> Henrik

Cheers,
  Hans-Peter
