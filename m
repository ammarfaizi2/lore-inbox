Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267846AbTAMRbz>; Mon, 13 Jan 2003 12:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTAMRbz>; Mon, 13 Jan 2003 12:31:55 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:33753 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267846AbTAMRby> convert rfc822-to-8bit; Mon, 13 Jan 2003 12:31:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: root@chaos.analogic.com
Subject: Re: Nvidia and its choice to read the GPL "differently"
Date: Mon, 13 Jan 2003 11:37:29 -0600
User-Agent: KMail/1.4.1
Cc: Richard Stallman <rms@gnu.org>, R.E.Wolff@BitWizard.nl, jalvo@mbay.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1030113121925.26995A-200000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030113121925.26995A-200000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131137.29161.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 January 2003 11:22 am, Richard B. Johnson wrote:
[snip]
>
> The early Ygddrasil distributions, of which I posted the 'grep'
> several days ago, show that most of the files are BSD based.
>
> I attach it here for your pleasure.

Ummm you did a "strings *" twice in the /usr/bin directory....

Though I grant that is still a relatively small number of actual programs.
The style they used tended to have one such line per main program
(and assuming that was true then too) what you have is only
69 files. /bin only has 8, and /sbin only 4.

How many other files were there? If none, then that distribution
would be BSD based.

Wish I still had my SLS distribution floppies... That would make
a nice cross check.

I still don't believe the current distributions include that many
files any more. There was a request from UCLA to remove propriatary
code from the distributions. The major effect was to purge the
network code out of the kernel, but it also removed a LOT of user
code as well... My mail archives don't go back that far but I think
it was around 92/93/94 timeframe.

Personally, I think that was the most damaging thing done to BSD.
Before that, I used to consider using BSD for production, and Linux
for testing. It was said to "use linux for the latest thing, but if you
need stability, use BSD". And it appeared relatively simple to switch
between the two kernels up to that time...

BSD made a contribution then... But it's over.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
