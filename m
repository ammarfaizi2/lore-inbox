Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135201AbRDVDjP>; Sat, 21 Apr 2001 23:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135202AbRDVDjE>; Sat, 21 Apr 2001 23:39:04 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:25348 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135201AbRDVDiz>;
	Sat, 21 Apr 2001 23:38:55 -0400
Date: Sat, 21 Apr 2001 23:39:17 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010421233917.D15644@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421194706.A14896@thyrsus.com> <E14r7Kw-0004dU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14r7Kw-0004dU-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 01:02:44AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> 99.9999% of problems don't involve querying the set of maintainers of
> Confg.in files. The system is optimised to the general case of queries people
> need to make. It also happens to be accessible to people who are not
> kernel gurus because it uses roughly English terms for the maintainership
> and area.
> 
> The .0001% case isnt interesting. Thats the difference between real world 
> systems and theory.

Again with due respect, you haven't gotten it yet.  In fact, you've
got it exactly backwards.  Unsurprising -- you're so magnificently
well adapted to the way things are that certain limiting assumptions
of the system you operate in have become invisible to you.

What you call a rare case is rare not because it *should* be rare but because
the work practices and social mechanisms of lkml combine to heavily discourage
improvements that cross jurisdictional boundaries.  

This is a *problem*.  I won't belabor the point, because I am certain
that you'll believe the conclusion more if you figure it out yourself than
if I tell you.  Hint: think about long-term coherency issues in large
codebases.  Think hard.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
