Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbRFYCv5>; Sun, 24 Jun 2001 22:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265855AbRFYCvr>; Sun, 24 Jun 2001 22:51:47 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:60573 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265850AbRFYCv3>; Sun, 24 Jun 2001 22:51:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Larry McVoy <lm@bitmover.com>, "J . A . Magallon" <jamagallon@able.es>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Sun, 24 Jun 2001 16:24:33 -0400
X-Mailer: KMail [version 1.2]
Cc: landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <20010625003002.A1767@werewolf.able.es> <20010624165024.H8832@work.bitmover.com>
In-Reply-To: <20010624165024.H8832@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <0106241624340C.03436@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 19:50, Larry McVoy wrote:
> On Mon, Jun 25, 2001 at 12:30:02AM +0200, J . A . Magallon wrote:
> > They use fork().
> > They port their app to solaris.
> > The performance sucks.
> > It is not Solaris fault.
> > It is linux fast fork() ...
>
> One for the quotes page, eh?  We're terribly sorry, we'll get busy on
> adding some delay loops in Linux so it too can be slow.

I'm still working that one out myself...

Okay, so Linux programmers are supposed to avoid APIs that are either 
broken, badly implemented, or missing, on some other platform.

That's pretty much all of them, isn't it?

Rob
