Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSA3B3o>; Tue, 29 Jan 2002 20:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSA3B3e>; Tue, 29 Jan 2002 20:29:34 -0500
Received: from adsl-187-220.38-151.net24.it ([151.38.220.187]:23055 "EHLO
	karis.localdomain") by vger.kernel.org with ESMTP
	id <S287872AbSA3B3W>; Tue, 29 Jan 2002 20:29:22 -0500
Message-Id: <200201300132.g0U1WDB24547@karis.localdomain>
Date: Wed, 30 Jan 2002 02:32:13 +0100
From: Francesco Munda <syylk@tiscalinet.it>
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C56943E.60405@antefacto.com>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
	<200201290137.g0T1bwB24120@karis.localdomain>
	<3C56943E.60405@antefacto.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 12:23:26 +0000
Padraig Brady <padraig@antefacto.com> wrote:

> Currently the way I see it [should be] currently is:
> 
> [cut-n-pasted graph]
> 
> I.E. Linus just gets input from the combiners which
> test logic from the maintainers in combination. Also
> random hackers should input to the combiners and not Linus
> if there isn't an appropriate maintainer for their code.

Quite descriptive and useful, thanks.

Let me raise a point. And extend your graph:

random hackers
| | | | | | |
| maintainers -< subsys testers
| | | |
combiners -< tree testers
| |
Linus

Who you call combiners... How many of them should release independent trees
to be thrown at us test-dogs? My point of view is neither the hacker, nor the
maintainer nor the combiner one. Nor Linus, thank god! :) It's the guy who
risks his filesystem integrity with some 2.X.Y-preZ-testW-QQ-KK kernel.

How many crosspatched sources I should look at, to try my luck with?

Have fun,

-- Francesco

