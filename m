Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132013AbRAXMkj>; Wed, 24 Jan 2001 07:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132022AbRAXMk3>; Wed, 24 Jan 2001 07:40:29 -0500
Received: from coruscant.franken.de ([193.174.159.226]:7 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S132013AbRAXMkX>; Wed, 24 Jan 2001 07:40:23 -0500
Date: Wed, 24 Jan 2001 13:38:56 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Paul Jakma <paul@clubi.ie>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010124133856.X6055@coruscant.gnumonks.org>
In-Reply-To: <E14K7UY-0004hB-00@kabuki.eyep.net> <Pine.LNX.4.31.0101210746410.1046-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0101210746410.1046-100000@fogarty.jakma.org>; from paul@clubi.ie on Sun, Jan 21, 2001 at 07:47:30AM +0000
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 07:47:30AM +0000, Paul Jakma wrote:
> 
> uhmm... ICQ seems to work fine through connection tracking for me, so
> is there a need for a special ip_masq_icq module?

Certain features of ICQ, which require direct client to client connections,
don't work. 

Please move further discussion to the netfilter user mailinglist at
netfilter@lists.samba.org
> -- 
> Paul Jakma	paul@clubi.ie	paul@jakma.org

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
