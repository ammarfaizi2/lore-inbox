Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSA0IkO>; Sun, 27 Jan 2002 03:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287880AbSA0Ijz>; Sun, 27 Jan 2002 03:39:55 -0500
Received: from goliath.siemens.de ([194.138.37.131]:37102 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S287868AbSA0Iji> convert rfc822-to-8bit; Sun, 27 Jan 2002 03:39:38 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Hood <jdthood@mail.com>, Russell King <rmk@arm.linux.org.uk>,
        Andreas Steinmetz <ast@domdv.de>, linux-laptop@vger.kernel.org,
        laslo@wodip.opole.pl, linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Combined APM patch
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.11mdk 
Date: 27 Jan 2002 11:39:25 +0300
Message-Id: <1012120767.2456.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ðÎÄ, 2002-01-07 at 07:52, Stephen Rothwell wrote:
> Hi All,
> 
> This is my version of the combined APM patches;
> 
> 	Change notification order so that user mode is notified
> 		before drivers of impending suspends.
> 	Move the idling back into the idle loop.
> 	A couple of small tidy ups.
> 
> See header comments for attributions.
> 
> This works for me (including as a module).
> 
> Please test and let me know - it seems to lower my power requirements
> by about 10% on my Thinkpad (over stock 2.4.17).
> 

Just to confirm (albeit too late) that this one work just fine here.
Currently using Mandrake 2.4.17-10mdk kernel based on 2.4.18-pre7

Thank you

-andrej
