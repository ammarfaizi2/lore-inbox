Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280672AbRKFXP7>; Tue, 6 Nov 2001 18:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280671AbRKFXPu>; Tue, 6 Nov 2001 18:15:50 -0500
Received: from ns.suse.de ([213.95.15.193]:62729 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280670AbRKFXPk>;
	Tue, 6 Nov 2001 18:15:40 -0500
Date: Wed, 7 Nov 2001 00:15:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161FL2-00027E-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0111070012430.16759-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Alan Cox wrote:

> > If this is done, it should perhaps be done on only on certain x86s,
> > as some show the results go the other way. For example, the Cyrix III..
> Do we have many SMP Cyrix III's ?

I wish :)  Today no, tomorrow only VIA knows.
I just used that as an example that it may not be a win everywhere.
A better example perhaps was the P5 case Ricky posted, which as you
know, are seen in the real world in SMP.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

