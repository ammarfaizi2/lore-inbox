Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131707AbRBATAb>; Thu, 1 Feb 2001 14:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131639AbRBATAX>; Thu, 1 Feb 2001 14:00:23 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:37903 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131707AbRBATAM>;
	Thu, 1 Feb 2001 14:00:12 -0500
Date: Thu, 1 Feb 2001 11:59:41 -0700
From: yodaiken@fsmlabs.com
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@caldera.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201115941.B6715@hq.fsmlabs.com>
In-Reply-To: <E14ONzo-0004kq-00@the-village.bc.nu> <Pine.LNX.4.21.0102011628590.1321-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.21.0102011628590.1321-100000@duckman.distro.conectiva>; from Rik van Riel on Thu, Feb 01, 2001 at 04:32:48PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 04:32:48PM -0200, Rik van Riel wrote:
> On Thu, 1 Feb 2001, Alan Cox wrote:
> 
> > > Sure.  But Linus saing that he doesn't want more of that (shit, crap,
> > > I don't rember what he said exactly) in the kernel is a very good reason
> > > for thinking a little more aboyt it.
> > 
> > No. Linus is not a God, Linus is fallible, regularly makes mistakes and
> > frequently opens his mouth and says stupid things when he is far too busy.
> 
> People may remember Linus saying a resolute no to SMP
> support in Linux ;)

And perhaps he was right!

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
