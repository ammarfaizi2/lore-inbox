Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282141AbRKWNRC>; Fri, 23 Nov 2001 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282143AbRKWNQw>; Fri, 23 Nov 2001 08:16:52 -0500
Received: from [213.98.126.44] ([213.98.126.44]:47498 "HELO mitica.trasno.org")
	by vger.kernel.org with SMTP id <S282141AbRKWNQi>;
	Fri, 23 Nov 2001 08:16:38 -0500
To: =?iso-8859-1?q?Lu=EDs?= Henriques <umiguel@alunos.deis.isec.pt>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: copy to suer space
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk>
	<20011120123915.W1308@lynx.no>
	<20011120160657.A4124@mikef-linux.matchmail.com>
	<200111211057.fALAvi288566@criticalsoftware.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200111211057.fALAvi288566@criticalsoftware.com>
Date: 23 Nov 2001 14:14:50 +0100
Message-ID: <m2ofltljcl.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "luís" == Luís Henriques <umiguel@alunos.deis.isec.pt> writes:

>> This to me looks like the main desire is to fool the user.  It looks like
>> it doing something, but it really isn't...

luís> Not really... This may look like an old DOS virus :) but it is not! It's a 
luís> fault injection tool - it's purpose (in this case, of corse) is to cause a 
luís> very short delay on a critic process.

What is wrong putting a signal handler in your process for a signal,
and busy wait in that signal all the time that you want?

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
