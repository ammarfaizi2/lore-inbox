Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSGSF3t>; Fri, 19 Jul 2002 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSGSF3t>; Fri, 19 Jul 2002 01:29:49 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:45514 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S315709AbSGSF3s>; Fri, 19 Jul 2002 01:29:48 -0400
Message-Id: <200207190532.g6J5Wia87042@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: CaT <cat@zip.com.au>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Date: Thu, 18 Jul 2002 19:34:24 -0400
X-Mailer: KMail [version 1.3.1]
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net> <20020718213857.E23208@work.bitmover.com> <20020719044518.GK5608@zip.com.au>
In-Reply-To: <20020719044518.GK5608@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 July 2002 12:45 am, CaT wrote:
> On Thu, Jul 18, 2002 at 09:38:57PM -0700, Larry McVoy wrote:
> > On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> > > I've been sitting on this question for years, hoping I'd come
> > > across the answer, and I STILL don't know what the "i" is short for.
> > > Somebody here has got to know this. :)
> >
> > Incore node, I believe.  In the original Unix code there was dinode and
> > inode if I remember correctly, for disk node and incore node.
>
> That's a new one. I always thought it was 'information node' so in the
> above it'd be disk information node and just information node.
>
> Makes sense to me in any case. :)

So far I've also received off-list mails saying that it stands for "index" 
(this person cited "the design of the unix operating system", by Maurice J 
Bach, which I have on my shelf but don't remember that bit from), and another 
vote for "indirection" from somebody I recognize as being on this list longer 
than I have...

That's it, I'm going to go email Dennis Richie...

Rob
