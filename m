Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277119AbRJ3SI0>; Tue, 30 Oct 2001 13:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJ3SIQ>; Tue, 30 Oct 2001 13:08:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28945 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277119AbRJ3SIF>;
	Tue, 30 Oct 2001 13:08:05 -0500
Date: Tue, 30 Oct 2001 16:08:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "P.Agenbag" <internet@psimation.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13 kernel and ext3???
In-Reply-To: <3BDEE870.1060104@psimation.com>
Message-ID: <Pine.LNX.4.33L.0110301605320.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, P.Agenbag wrote:

> Does it mean that if there is a fairly large difference between the
> RedHat 2.4.7 and the stock one from kernel.org, that they are not
> really the same?

Indeed, but that's a good thing because people often want/need
more features or bugfixes than what's in the standard kernel.

> ie, does anyone foresee any future problems with redhat adding
> all these extra features to their kernel and people who would like to
> upgrade to a newer version ( for one, I selected ext3 during install,
> yet, now trying to install 2.4.13, I must revert back to ext2...)

ext3 has been in Alan's kernels for a while now, you can
always upgrade to a new -ac kernel and keep using ext3.

Also, the fact that ext3 isn't available in 2.4 -linus
doesn't sound like a good reason to not make this useful
feature available to the users of Linux distributions ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

