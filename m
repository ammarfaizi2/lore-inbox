Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290322AbSA3SFs>; Wed, 30 Jan 2002 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290299AbSA3SEa>; Wed, 30 Jan 2002 13:04:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36310 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290115AbSA3SDe>;
	Wed, 30 Jan 2002 13:03:34 -0500
Date: Wed, 30 Jan 2002 13:03:32 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Jochen Friedrich <jochen@scram.de>
Cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130130332.B28741@havoc.gtf.org>
In-Reply-To: <20020130080642.E18381@work.bitmover.com> <Pine.NEB.4.33.0201301731530.16245-100000@www2.scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.33.0201301731530.16245-100000@www2.scram.de>; from jochen@scram.de on Wed, Jan 30, 2002 at 05:34:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 05:34:12PM +0100, Jochen Friedrich wrote:
> > with the difference being that BK has an optional way of wrapping
> > them up in uuencode (or whatever) so that mailers don't stomp on them.
> 
> isn't that just the same as sending them as attchment? And isn't that
> discouraged?

gcc developers love that uuencoded stuff for large files it seems, but
it's not big in l-k land...  plaintext patches are preferred.  The main
requirement is that the patch is NOT obscured by base64 or uuencoding.

	Jeff


