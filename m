Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbRG0PeS>; Fri, 27 Jul 2001 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRG0PeK>; Fri, 27 Jul 2001 11:34:10 -0400
Received: from [194.213.32.142] ([194.213.32.142]:5892 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267643AbRG0Pd4>;
	Fri, 27 Jul 2001 11:33:56 -0400
Date: Mon, 23 Jul 2001 14:10:31 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Journaling FS Comparison
Message-ID: <20010723141028.B39@toy.ucw.cz>
In-Reply-To: <20010722162150.A23381@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010722162150.A23381@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Sun, Jul 22, 2001 at 04:21:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

> ext3 stands out because of it's compatibility with ext2 - this makes
> it easy to 'upgrade' from ext2 to ext3 without loosing/moving data.
> Also it would be much easier to move a drive into another machine
> without worrying about the kernel having reiserfs etc compiled in.

Plus, ext2 has *very* good fsck, tested by years.

Last time I ran reiserfsck, it found some errors, but warned me *against*
trying to fix them. I have SuSE7.2 system on reiserfs, and fsck complains
slighlty. System seems to work well. How do I fix it up? Is reiserfsck
really so dangerous as it cllaims?
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

