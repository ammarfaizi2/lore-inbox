Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbRAAUZk>; Mon, 1 Jan 2001 15:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRAAUZa>; Mon, 1 Jan 2001 15:25:30 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:31671 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130669AbRAAUZW>; Mon, 1 Jan 2001 15:25:22 -0500
Date: Mon, 1 Jan 2001 20:54:52 +0100
From: David Weinehall <tao@acc.umu.se>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS2ESDI
Message-ID: <20010101205452.C6552@khan.acc.umu.se>
In-Reply-To: <Pine.GSO.4.10.10101011318090.5177-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.10.10101011318090.5177-100000@sound.net>; from hald@sound.net on Mon, Jan 01, 2001 at 01:35:18PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2001 at 01:35:18PM -0600, Hal Duston wrote:
> In moving from 2.2.x to 2.4.x I have found that PS/2 Esdi will no
> longer boot.  The problem was introduced by what appears to have been
> a small architectural change that shouldn't have had an impact.  I am
> looking into it, if anyone has an idea of what could be causing this,
> please mail me.  The relevant change occured at 2.3.32-pre3 A new
> parameter was add to xxx_do_request.  The parameter isn't used by
> ps2esdi_do_request, but I can't see why it should have caused any
> drive problems.  Hopefully, I will figure the problem out within the
> next week.

I'll look into it. Guess I'll have to get my 386 running again...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
