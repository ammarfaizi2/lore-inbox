Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSANS5F>; Mon, 14 Jan 2002 13:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288902AbSANS4K>; Mon, 14 Jan 2002 13:56:10 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:43139 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S288867AbSANSyi>; Mon, 14 Jan 2002 13:54:38 -0500
Date: Mon, 14 Jan 2002 13:54:31 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114131050.E14747@thyrsus.com>
Message-ID: <Pine.LNX.4.44.0201141353500.3238-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  And on that day linux will loose one small person .
		Taf ,  JimL

On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > For 2.5 if things go to plan there will be no such thing as a "compiled in"
> > driver. They simply are not needed with initramfs holding what were once the
> > "compiled in" modules.
>
> This is something of a bombshell.  Not necessarily a bad one, but...
>
> Alan, do you have *any* *freakin'* *idea* how much more complicated
> the CML2 deduction engine had to be because the basic logical entity
> was a tristate rather than a bool?  If this plan goes through, I'm
> going to be able to drop out at least 20% of the code, with most of
> that 20% being in the nasty complicated bits where the maintainability
> improvement will be greatest.  And I can get rid of the nasty "vitality"
> flag, which probably the worst wart on the language.
>
> Yowza...so how soon is this supposed to happen?
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> Government should be weak, amateurish and ridiculous. At present, it
> fulfills only a third of the role.	-- Edward Abbey
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

