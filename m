Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRDUXrK>; Sat, 21 Apr 2001 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbRDUXqu>; Sat, 21 Apr 2001 19:46:50 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:9476 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S133062AbRDUXqn>;
	Sat, 21 Apr 2001 19:46:43 -0400
Date: Sat, 21 Apr 2001 19:47:06 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010421194706.A14896@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421114942.A26415@thyrsus.com> <E14r6V4-0004XB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14r6V4-0004XB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 12:09:05AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> It scales perfectly.

I must say, in the most respectful way possible, "bullshit!"

Alan, if MAINTAINERS scaled perfectly I wouldn't have had to spend three months
just trying to figure out who was reponsible for each of the [Cc]onfig.in
files.  And even with that amount of effort mostly failing.

You only think the present attribution system scales well because your
position is, shall we say, *privileged*.  Maintainers come to you; you
don't normally have to try to track them down.  Me, I *know* that Andreas 
Dilger identified a real problem, because I've barked my fscking shins on it.
In two separate contexts now.

(There's a related rant I'm not ready to utter yet about how lkml's
social machinery is very poorly adapted to solving problems that cross
boundaries between different hackers' personal fiefdoms.)

I'm an unusually stubborn and persistent person, as you have cause to
know.  I really wonder how much good work we've lost because people less 
stubborn than me simply gave up on the friction costs of trying to identify
the responsible person(s) for the bits they wanted to change.

Andreas saw the problem, and he also saw the solution. It's to make
the structure of the attribution system match the structure of the
code -- and of the social machine that surrounds the code.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No one is bound to obey an unconstitutional law and no courts are bound
to enforce it.  
	-- 16 Am. Jur. Sec. 177 late 2d, Sec 256
