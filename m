Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262499AbTCIMDo>; Sun, 9 Mar 2003 07:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbTCIMDo>; Sun, 9 Mar 2003 07:03:44 -0500
Received: from pasky.ji.cz ([62.44.12.54]:2805 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262499AbTCIMDn>;
	Sun, 9 Mar 2003 07:03:43 -0500
Date: Sun, 9 Mar 2003 13:14:14 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Romain Lievin <roms@tilp.info>
Subject: Re: [PATCH] kconfig update
Message-ID: <20030309121414.GM3917@pasky.ji.cz>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Romain Lievin <roms@tilp.info>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv> <20030309085915.A14548@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309085915.A14548@infradead.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Mar 09, 2003 at 09:59:15AM CET, I got a letter,
where Christoph Hellwig <hch@infradead.org> told me, that...
> On Sun, Mar 09, 2003 at 04:57:54AM +0100, Roman Zippel wrote:
> > Hi,
> > 
> > It took a bit longer than I wanted, but here is finally another kconfig 
> > update. There are two important changes: I included Romain's gtk front 
> > end and the support for the menuconfig keyword.
> 
> Any chance you could take a look at the patch that links lxdialog directly
> to menuconfig instead of requiring the separate binary?  It has been
> around for a long time and seems like a very worthwhile change, imho.

It is me responsible for the delays and not being integrated yet, unfortunately
I didn't have time for proper debugging one problem in it yet :-( (broken
window resizing handler; Roman proposed some solution which I didn't manage to
try yet). I hope I will finally give it a final kick really soon.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
When in doubt, use brute force.
		-- Ken Thompson
.
Crap: http://pasky.ji.cz/
