Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264213AbRFLHKq>; Tue, 12 Jun 2001 03:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264216AbRFLHKh>; Tue, 12 Jun 2001 03:10:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17423 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264213AbRFLHK3>; Tue, 12 Jun 2001 03:10:29 -0400
Message-ID: <3B25BFEE.E9458B09@idb.hist.no>
Date: Tue, 12 Jun 2001 09:08:30 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: jacob@chaos2.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregistertable
In-Reply-To: <Pine.LNX.4.21.0106111126070.14070-100000@inbetween.blorf.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Luna Lundberg wrote:
> 
> On Mon, 11 Jun 2001, Alan Cox wrote:
> > "The source code for a work means the preferred form of the work for
>                                         ^^^^^^^^^
> Preferred by whom?  The FSF?  Richard Stallman?  Hackers in general when
> they take a vote?  Programmers in general?  What if the market is full of
> VB programmers who prefer VB?  What if none of them know assembly?  They
> might all vote that assembly isn't a preferred form.  If they aren't the
> ones who count, then who does?  Maybe the authors count for more than
> other people?  If so then it does seem they might like to write binaries
> because they're crazy and they think it's fun or something.  I think that
> the intention of the GPL is clear here but the language is not...

The intention _is_ clear indeed.  That ought to be all we need really.
If it comes to the worst and somneone in court claims that binary
is their preferred form for _modification_ - have them demonstrate their
way of working to prove it can be done.  "Now write 'hello world'
in binary.  Wow, you managed that!  Now add a triple loop to it..."
This could be really interesting.

Somehow, I believe a driver written directly in binary (without even
assembly source) would be easy to reimplement from scratch in C.  
Because it'd be so small.

Helge Hafting
