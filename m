Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSB0ARU>; Tue, 26 Feb 2002 19:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSB0ARL>; Tue, 26 Feb 2002 19:17:11 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:47865 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S290302AbSB0AQ6>; Tue, 26 Feb 2002 19:16:58 -0500
Date: Tue, 26 Feb 2002 16:24:03 -0800
From: Chris Wright <chris@wirex.com>
To: "Dennis, Jim" <jdennis@snapserver.com>
Cc: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: crypto (was Re: Congrats Marcelo,)
Message-ID: <20020226162403.A6964@figure1.int.wirex.com>
Mail-Followup-To: "Dennis, Jim" <jdennis@snapserver.com>,
	'Jeff Garzik' <jgarzik@mandrakesoft.com>,
	Andreas Dilger <adilger@turbolabs.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD6@cdserv.meridian-data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD6@cdserv.meridian-data.com>; from jdennis@snapserver.com on Tue, Feb 26, 2002 at 03:18:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dennis, Jim (jdennis@snapserver.com) wrote:
<snip>
> As for LIDS, grsecurity, etc: I suspect it will be a cold day in hell
> before Linus includes any of those into the mainstream.  I think it is
> sufficient that he's willing to accommodate the LSM (security module)
> to provide a common interface to all of the competing kernel hardening
> packages.
<snip>

You may interested to know, LIDS has been ported to LSM, which is kept
up-to-date for stable 2.4 releases, and (for those with bitkeeper) all
2.5-pres/stable.

cheers,
-chris
