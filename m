Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSA3P3R>; Wed, 30 Jan 2002 10:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289300AbSA3P3G>; Wed, 30 Jan 2002 10:29:06 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:31973
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S289278AbSA3P25>; Wed, 30 Jan 2002 10:28:57 -0500
Date: Wed, 30 Jan 2002 16:28:51 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        killeri@iki.fi
Subject: Re: Wanted: Volunteer to code a Patchbot
Message-ID: <20020130162851.H9765@jaquet.dk>
In-Reply-To: <Pine.LNX.4.33.0201301306190.7674-100000@serv> <E16VumS-0000EM-00@starship.berlin> <20020130161105.E9765@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130161105.E9765@jaquet.dk>; from rasmus@jaquet.dk on Wed, Jan 30, 2002 at 04:11:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 04:11:05PM +0100, Rasmus Andersen wrote:
> If I understand correctly, the bot would, in its basic incarnation,
> accept patches (at patchbot@somewhere), stamp them with an uid,
> and forward them to various places, e.g., lists, maintainers etc
> and let the sumbitter know the patch uid. A mailing list archive
> would then be the patch store. Basic filtering could be done by
> the bot to reject non-patches etc.

Somehow, I totally forgot the security disclaimer for some of
the points. Obviously, mindlessly patching a makefile and
executing it would be a Bad Idea. If no satisfying solution
to this can be found, this (execute/compile) step could be 
foregone.

Thanks to Tommy Faasen for raising this point.

Regards,
  Rasmus
