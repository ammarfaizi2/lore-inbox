Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQJaWGE>; Tue, 31 Oct 2000 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbQJaWFy>; Tue, 31 Oct 2000 17:05:54 -0500
Received: from Cantor.suse.de ([194.112.123.193]:47365 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130791AbQJaWFl>;
	Tue, 31 Oct 2000 17:05:41 -0500
Date: Tue, 31 Oct 2000 23:05:38 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: mingo@elte.hu, Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031230538.A9048@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu> <39FF3F0B.81A1EE13@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FF3F0B.81A1EE13@timpanogas.org>; from jmerkey@timpanogas.org on Tue, Oct 31, 2000 at 02:52:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 02:52:11PM -0700, Jeff V. Merkey wrote:
> The numbers don't lie.  You know where the code is.  You notice that
> there is a version of
> the kernel hand coded in assembly language.  You'l also noticed that
> it's SMP and takes ZERO LOCKS during context switching, in fact, most of
> the design is completely lockless.

I suspect most of the confusion in this thread comes because you seem to 
use a different definition of context switch than Ingo and others. Could
you explain what you exactly mean with a context switch ? 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
