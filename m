Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283741AbRK3SHv>; Fri, 30 Nov 2001 13:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283739AbRK3SHs>; Fri, 30 Nov 2001 13:07:48 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:31751 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S283738AbRK3SHg>; Fri, 30 Nov 2001 13:07:36 -0500
Subject: Re: Coding style - a non-issue
From: Henning Schmiedehausen <hps@intermeta.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111301226190.15083-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111301226190.15083-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 19:07:25 +0100
Message-Id: <1007143646.8939.45.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 18:55, Alexander Viro wrote:

Hi,

> On 30 Nov 2001, Henning Schmiedehausen wrote:
> 
> > issue. Code that you consider ugly as hell may be seen as "easily
> > understandable and maintainable" by the author. If it works and has no
> > bugs, so what? Just because it is hard for you and me to understand (cf.
> 
> ... it goes without peer review for years.  And that means bugs.

That's right. And I didn't say, that _this is a good thing_. The
question was (and is IMHO), "do we put such code into a "hall of driver
writer shame" or do we either just reject the code from the kernel tree
or do we help "the poor misunderstood vendor" to convert.

Simply flaming them down will definitely not help. As someone with your
experience should know, too.

> Sigh...  Ironic that _you_ recommend somebody to grow up - I would expect
> the level of naivety you'd demonstrated from a CS grad who'd never worked
> on anything beyond his toy project.  Not from somebody adult.

You're welcome.

I'm willing to give you a bet: You put up such a "hall of shame" and we
will see what comes first:

a) media echo that "linux core developers start insulting code
committers"

or

b) vendors start cleaning up their code.



	Regards
		Henning

 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

