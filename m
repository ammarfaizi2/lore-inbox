Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276327AbRJHEjy>; Mon, 8 Oct 2001 00:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRJHEjo>; Mon, 8 Oct 2001 00:39:44 -0400
Received: from [192.132.92.2] ([192.132.92.2]:56486 "EHLO
	bitmover.bitmover.com") by vger.kernel.org with ESMTP
	id <S276327AbRJHEjj>; Mon, 8 Oct 2001 00:39:39 -0400
Date: Sun, 7 Oct 2001 21:40:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: sis630/celeron perf sucks?
Message-ID: <20011007214009.A3608@work.bitmover.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011006130647.B26223@work.bitmover.com> <01100618241801.05593@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01100618241801.05593@localhost.localdomain>; from landley@trommello.org on Sat, Oct 06, 2001 at 06:24:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Run memtest86 to see what your memory bandwidth is.

As far as I know, LMbench tells me what my memory bandwidth is just fine.
I don't care if it is telling me the limit (I know it isn't) I only need
to know relative speeds across platforms.  It does that.

> Yup.  Blame Intel's marketing department.  This isn't a SIS problem, that's 
> pure Intel's crippling of the DeCeleron...

I checked with a guy who works here, he used to work in Intel's processor
group on performance, and he tells me it isn't the processor, it's the 
motherboard.  Which jives nicely with the data.

I'm just hoping there is some SiS genius out there who will ask me

"Did you remember to turn off the go 3x slower mode in the BIOS?"

and I'll hang my head in shame and ask to be directed to that magic
BIOS switch.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
