Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbTCOWPA>; Sat, 15 Mar 2003 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbTCOWPA>; Sat, 15 Mar 2003 17:15:00 -0500
Received: from pasky.ji.cz ([62.44.12.54]:53499 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261626AbTCOWO6>;
	Sat, 15 Mar 2003 17:14:58 -0500
Date: Sat, 15 Mar 2003 23:25:48 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][kconfig][i386] Fix help entry for processor type choice
Message-ID: <20030315222548.GG31875@pasky.ji.cz>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
References: <20030315214558.GE31875@pasky.ji.cz> <200303152222.h2FMMbb20136@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303152222.h2FMMbb20136@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Mar 15, 2003 at 11:22:37PM CET, I got a letter,
where Alan Cox <alan@redhat.com> told me, that...
> > +	  Select this for a 386 series processor, that is AMD/Cyrix/Intel
> > +	  386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2, UMC 486SX-S and NexGen
> > +	  Nx586. Kernel compiled for this processor will also run on any newer
> > +	  processor of this architecture, although not optimally fast.
> 
> There are about ten other processors. Trying to list them all is going
> to send people potty. Also some UMC don't work with this or any other
> option. 
> 
> The list you have now looks pretty sensible as a basis.

I just copied these from the original CONFIG_M386 help (now the common
"Processor type" help).

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
