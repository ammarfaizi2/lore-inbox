Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbRANOjF>; Sun, 14 Jan 2001 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRANOi4>; Sun, 14 Jan 2001 09:38:56 -0500
Received: from [63.95.87.168] ([63.95.87.168]:20999 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S130462AbRANOil>;
	Sun, 14 Jan 2001 09:38:41 -0500
Date: Sun, 14 Jan 2001 09:38:36 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: Re: low-latency scheduling patch for 2.4.0
Message-ID: <20010114093836.C10910@xi.linuxpower.cx>
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> <3A618F17.FD285E2B@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A618F17.FD285E2B@uow.edu.au>; from andrewm@uow.edu.au on Sun, Jan 14, 2001 at 10:35:51PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 10:35:51PM +1100, Andrew Morton wrote:
[snip]
> - The patch now works properly on SMP.
[snip]

Any benchmark results on SMP yet?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
