Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbRDXNU1>; Tue, 24 Apr 2001 09:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135602AbRDXNUU>; Tue, 24 Apr 2001 09:20:20 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38160 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135599AbRDXNSU>; Tue, 24 Apr 2001 09:18:20 -0400
Date: Tue, 24 Apr 2001 15:18:09 +0200 (CEST)
From: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
Reply-To: ttel5535@artax.karlin.mff.cuni.cz
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104240846000.21785-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.21.0104241508370.11387-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> trustix.co.id?  hehehe.
> 
> If you don't want to login with user/password, then change your
> password to "".  Don't want to even do that?  Then just change
> /etc/inittab to invoke "login -f username" instead of mingetty or
> whatever.  No need at all to hack the kernel up.
> 
> Dunno why you sent the patch here or to Linus though..  The
> chance of it even being looked at are about 1/2^infinity  ;o)

:-) Great.
You and Alex are right - I agree that this is a complete moronism.

But, what I should say to the network security, is that AFAIK in the most
of linux distributions the standard daemons (httpd, sendmail) are run as
root! Having multi-user system or not! Why? For only listening to a port
<1024? Is there any elegant solution?

  Tomas



