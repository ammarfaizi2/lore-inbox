Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132128AbRAXAia>; Tue, 23 Jan 2001 19:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRAXAiU>; Tue, 23 Jan 2001 19:38:20 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28680 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132128AbRAXAiM>;
	Tue, 23 Jan 2001 19:38:12 -0500
Date: Wed, 24 Jan 2001 01:38:00 +0100
From: Andi Kleen <ak@suse.de>
To: Pete Elton <elton@iqs.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <20010124013800.A12632@gruyere.muc.suse.de>
In-Reply-To: <20010124011011.A12252@gruyere.muc.suse.de> <200101240027.QAA14665@tech1.nameservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101240027.QAA14665@tech1.nameservers.com>; from elton@iqs.net on Tue, Jan 23, 2001 at 04:27:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 04:27:21PM -0800, Pete Elton wrote:
> Any ideas on how I can turn off the arping?  I guess the thing that I 

I explained it in my last mail how to do it using arpfilter. I do not claim 
that it is an elegant solution.

It's probably not worse a hack than hidden is in the first place though.

> am most curious about is how it ending up being removed from the kernel
> in the first place.  It must have been a decision that someone made.
> Either, we don't need that any more since we can do it this way, or
> we'll take it out since nobody uses it.

It was only submitted to 2.2 a few months ago (=years after 2.3 branched), but 
never added to 2.4. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
