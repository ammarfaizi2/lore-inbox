Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSCRWnU>; Mon, 18 Mar 2002 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCRWnR>; Mon, 18 Mar 2002 17:43:17 -0500
Received: from bitmover.com ([192.132.92.2]:34964 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293201AbSCRWm4>;
	Mon, 18 Mar 2002 17:42:56 -0500
Date: Mon, 18 Mar 2002 14:42:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020318144255.Y10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 10:26:18PM +0100, Pavel Machek wrote:
> Bitkeeper distribution contains stuff from GNU diffutils (copyrighted
> by FSF and GPL), yet bitkeeper docs does not mention its GPL-ed, and
> does not contain pointer to the sources. [I pointed couple other
> issues.]

You forgot to mention that the source in question is at

	ftp://ftp.bitmover.com/gnu

You also forgot to mention that we have tried to contribute our changes
back only to have them dropped/ignored/whatever.  We'd love the FSF to
pick them up, I can go dig out the old mail on this if you doubt me or
you can go talk to the maintainer.  I think I was talking with one of
the Pauls, either Eggert or Vixie, I don't remember who maintains this
stuff anymore.  Whoever it was said they had a different way to do the
same change.

> Larry's attitude is "you should shut up and be glad you may use this
> for free" and "sue me to get GPL issues fixed". 

Larry's attitude is that he's overworked, stressed out, and sick to death
of people who want to argue with him about pointless stuff.  The only
thing we did wrong was to forget the diff/patch man pages which include
the GPL in our binary distribution.  We'll fix that.  You are welcome 
to make a big deal out of it but it's pretty clear that all it is a 
political ax that you want to grind, since we give out the source to
those programs and always will.

Pavel, the problem here is your fundamental distrust.  You started out
the conversation claiming that you thought our code should be GPLed
because our installer groups GPLed programs with non-GPLed programs.
My statements about lawsuits are based your claims to that effect.

Then you go on to complain that the installer doesn't let you see what it
does when you can tell it to just drop the tar.gz and the shell script
in /tmp so you can see what it does.  That wasn't good enough for you,
you don't want the installer to be a binary, you mistrust us enough that
you think we're going to do some evil thing in the installer.  It would
take you all of 30 seconds to put strace into a copy of the ftp chroot,
stick the installer binary in there, and strace the installer and *prove*
to yourself that it does nothing evil.  But that's too much for you.

If you had started out the conversation "Hey, can I see your installer
source, I want to see how it works", you would have gotten a shar file 10
minutes later.  But that's obviously not what you want, you are itching
to pick a fight.  Great.  Thanks for wasting more of my time.

I'd suggest you take Stallman's advice, if you don't trust BitKeeper
then don't use it.   He asked you why you installed it if you knew
you didn't like the license and you never answered.

I'll say to you and the rest of the kernel list and anyone else who
is listening: don't waste my time with this crap.  If you don't like
the BK license, then don't use it.  Go read this, this is you Pavel,
and I'm sick of arguing with people like you.

http://www.linuxandmain.com/essay/sgordon.html

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
