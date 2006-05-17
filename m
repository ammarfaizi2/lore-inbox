Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWEQMjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWEQMjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWEQMjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:39:39 -0400
Received: from web26605.mail.ukl.yahoo.com ([217.146.176.55]:20851 "HELO
	web26605.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932541AbWEQMji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:39:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cfcW5LSEqcrLVCRdtiOkwARUMDXCKac1Pl2xvAIjoHe9VFXSJKIrQMWzSPYW5Y/b5romfaJDuA/qG/wJaNOkEIy65/vEgRI7aTpm3CCgXRJhz+EEROwwWTAywt/YWbpbemgDrNcfRkLU0qe1oyyKrTFYwzYcvztvdnD5SsuHpZA=  ;
Message-ID: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
Date: Wed, 17 May 2006 14:39:37 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Valdis.Kletnieks@vt.edu a écrit : 
> On Wed, 17 May 2006 13:47:22 +0200, linux cbon said:
> 
> If it isn't backward compatible, people won't use
> it.  X may suck,
> but it doesn't suck hard enough that people will
> abandon all their
> currently mostly-working software.

If we have a new window system, shall all applications
be rewritten ?


> Actually, you've proved the opposite.  Consider if
> the kernel had *already*
> included some universal window system (we'll call it
> W). At that point, you
> can't easily write an X, Y, or Z if you don't like
> W.  If anything, the
> *current* W (which happens to be called X11) is
> *too* friendly with the kernel
> already - witness all the headaches dealing with DRM
> and 'enable' attributes
> and other hoops things have to jump through.
> 
> If anything, there should be even *less* kernel
> support for graphics.
> That way, writing a Y or Z (or improving X) is
> easier to do without
> destabilizing the kernel.

My idea is that the kernel should include universal
graphical support.
And then we would NOT need ANY window system AT ALL.
We wouldnt have 2 os (kernel and X) at the same time
like now.
It would be faster, simpler, easier to manage etc.






	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
