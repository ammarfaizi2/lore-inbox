Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbQLHCLI>; Thu, 7 Dec 2000 21:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQLHCK6>; Thu, 7 Dec 2000 21:10:58 -0500
Received: from Cantor.suse.de ([194.112.123.193]:47620 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130205AbQLHCKv>;
	Thu, 7 Dec 2000 21:10:51 -0500
Date: Fri, 8 Dec 2000 02:40:18 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Andi Kleen <ak@suse.de>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001208024018.A6673@gruyere.muc.suse.de>
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <20001208022044.A6417@gruyere.muc.suse.de> <3A303852.790E3CE4@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A303852.790E3CE4@timpanogas.org>; from jmerkey@timpanogas.org on Thu, Dec 07, 2000 at 06:24:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 06:24:34PM -0700, Jeff V. Merkey wrote:
> 
> Andi,
> 
> It's related to some change in 2.4 vs. 2.2.  There are other programs
> affected other than X, SSH also get's spurious signal 11's now and again
> with 2.4 and glibc <= 2.1 and it does not occur on 2.2.

So have you enabled core dumps and actually looked at the core dumps 
of the programs using gdb to see where they crashed ? 



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
