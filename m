Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSALVCm>; Sat, 12 Jan 2002 16:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287472AbSALVCd>; Sat, 12 Jan 2002 16:02:33 -0500
Received: from codepoet.org ([166.70.14.212]:11431 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287478AbSALVCN>;
	Sat, 12 Jan 2002 16:02:13 -0500
Date: Sat, 12 Jan 2002 14:02:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112210213.GA31236@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jan 12, 2002 at 12:23:09PM -0800, Andrew Morton wrote:
> Ed Sweetman wrote:
> > 
> > If you want to test the preempt kernel you're going to need something that
> > can find the mean latancy or "time to action" for a particular program or
> > all programs being run at the time and then run multiple programs that you
> > would find on various peoples' systems.   That is the "feel" people talk
> > about when they praise the preempt patch.
> 
> Right.  And that is precisely why I created the "mini-ll" patch.  To
> give the improved "feel" in a way which is acceptable for merging into
> the 2.4 kernel.
> 
> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.

I've tested it.  I've been running it on my box for the last
several days.  Works just great.  My box has been quite solid
with it and I've not seen anything to prevent your sending it 
to Marcelo for 2.4.18...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
