Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264024AbRFEQDZ>; Tue, 5 Jun 2001 12:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264027AbRFEQDP>; Tue, 5 Jun 2001 12:03:15 -0400
Received: from u-87-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.87]:42223
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S264024AbRFEQDD>; Tue, 5 Jun 2001 12:03:03 -0400
Date: Tue, 5 Jun 2001 17:10:48 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Missing cache flush.
Message-ID: <20010605171048.A30818@bacchus.dhis.org>
In-Reply-To: <9fhqlj$7jt$1@penguin.transmeta.com> <Pine.LNX.4.33.0106051027390.2339-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106051027390.2339-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Jun 05, 2001 at 10:29:28AM +0200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 10:29:28AM +0200, Ingo Molnar wrote:

> >  - even when it works, it is necessarily very very very slow. Not to be
> >    used lightly. As you can imagine, the work-around is even slower.
> 
> i've measured it once, IIRC it was around 10-15 millisecs on normal
> pentiums, so while it's indeed the slowest x86 instruction on the planet,
> it's still perhaps acceptable for hot-swapping ECC RAM.

I can already hear the realtime crowd bitch ...

  Ralf
