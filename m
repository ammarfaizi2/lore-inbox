Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282821AbRK0Gjt>; Tue, 27 Nov 2001 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282822AbRK0Gjj>; Tue, 27 Nov 2001 01:39:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:39689 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282821AbRK0GjW>;
	Tue, 27 Nov 2001 01:39:22 -0500
Subject: Re: a nohup-like interface to cpu affinity
From: Robert Love <rml@tech9.net>
To: Linux maillist account <l-k@mindspring.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20011127011901.009ebd30@pop.mindspring.com>
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
	<E16744i-0004zQ-00@localhost>
	<Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	<1006472754.1336.0.camel@icbm> <E16744i-0004zQ-00@localhost>
	<5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com> 
	<5.0.2.1.2.20011127011901.009ebd30@pop.mindspring.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 01:39:50 -0500
Message-Id: <1006843191.838.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 01:32, Linux maillist account wrote:

> It's isn't quite the same..the biggest difference is races.

Then you can set the affinity on your shell before executing the
process. :)

But, OK OK -- I see your point.  It would make for a handy utility, and
it has some necessary uses (i.e., the race issue you brought up).

Question now is, what interface to do we export to userspace.

 	Robert Love

