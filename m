Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSBFWSi>; Wed, 6 Feb 2002 17:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290845AbSBFWS0>; Wed, 6 Feb 2002 17:18:26 -0500
Received: from femail6.sdc1.sfba.home.com ([24.0.95.86]:43968 "EHLO
	femail6.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290843AbSBFWSQ>; Wed, 6 Feb 2002 17:18:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Wed, 6 Feb 2002 17:19:17 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com> <87g04eljw6.fsf@CERT.Uni-Stuttgart.DE>
In-Reply-To: <87g04eljw6.fsf@CERT.Uni-Stuttgart.DE>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020206221815.QHBA1241.femail6.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 February 2002 10:17 am, Florian Weimer wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> > The long-range plan, and the real payoff, comes if main developers start
> > using bk too, which should make syncing a lot easier. That will take some
> > time, I suspect.
>
> Do you think that at some point, using BitKeeper will become mandatory
> for subsystem maintainers?  ("mandatory" in the sense that
> non-BitKeeper input is dealt with in a less timely fashion, for
> example.)

The hierarchy seems to be two levels deep now.  Linus doesn't accept patches 
from all 300 maintainers anyway, he has a group of a dozen or so lieutenants. 
 (Andre Hedrick has to send code to Jens Axboe, for example, before Linus 
will take it.)

Being a lieutenant would have to require bitkeeper before simply being a 
maintainer would.  I doubt it would ever work its way to simple developers 
submitting to maintainers.

(This is, of course, just my take on things...)

Rob
