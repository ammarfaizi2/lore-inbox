Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSCKSfQ>; Mon, 11 Mar 2002 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCKSe5>; Mon, 11 Mar 2002 13:34:57 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:6671 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S285424AbSCKSev>;
	Mon, 11 Mar 2002 13:34:51 -0500
Date: Sun, 10 Mar 2002 21:27:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020310202745.GB173@elf.ucw.cz>
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <3C880541.E04EFAB3@zip.com.au> <15496.6235.723025.422239@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15496.6235.723025.422239@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The problem I find is that I often want to take (file1+patch) -> file2,
> > when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
> > I haven't seen a graphical tool which helps you to wiggle a patch into
> > a file.
> 
> If your saying what I think you're saying, I completely agree.
> I often run "patch" and it drops some chunk because it doesn't match,
> and it turns out that the miss-match is just one or two lines in a
> chunk that could be very big.
> I would like a tool (actually an emacs mode) that would show me exactly
> why a patch fails, and allow me to edit bits until it fits, and then
> apply it.  I assume that is what you mean by "wiggle a patch into a file".

Yes, this would be [: very very :] nice.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
