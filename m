Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVEaUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVEaUgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVEaUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:34:35 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:22938 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261442AbVEaUdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:33:05 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 1/1] kconfig: trivial cleanup
Date: Tue, 31 May 2005 22:35:34 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
References: <20050529174525.A36D7A2FA3@zion.home.lan> <Pine.LNX.4.61.0505311123310.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0505311123310.3728@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505312235.35234.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 11:27, Roman Zippel wrote:
> Hi,
>
> On Sun, 29 May 2005 blaisorblade@yahoo.it wrote:
> > If you want, I'll do one patch update the included version to 2.0 Bison
> > (which uses an updated skeleton) and then, separately, a patch updating
> > zconf.tab.c_shipped to reflect the updated zconf.y.

> I'd prefer to patch the changes into zconf.tab.c_shipped directly. At some
> point it should be regenerated, but I'd like to avoid it and only do it if
> the parser itself needs a change.
I can regenerate it only with bison 2.0, since that's what I have installed. 
So if you don't want it to be regenerated, you cannot accept my patch. I 
proposed sending two patches to avoid mixing the bison changes with this 
patch changes, that's all.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
