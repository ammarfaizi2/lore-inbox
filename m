Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHXO6x>; Sat, 24 Aug 2002 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSHXO6x>; Sat, 24 Aug 2002 10:58:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316446AbSHXO6w>;
	Sat, 24 Aug 2002 10:58:52 -0400
Date: Sat, 24 Aug 2002 17:12:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Larry McVoy <lm@work.bitmover.com>
Cc: linux-kernel@vger.kernel.org, bitkeeper-announce@work.bitmover.com
Subject: BKWeb Feature request [Was: BK license change]
Message-ID: <20020824171245.C1889@mars.ravnborg.org>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, bitkeeper-announce@work.bitmover.com
References: <200208240039.g7O0dZf12300@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208240039.g7O0dZf12300@work.bitmover.com>; from lm@work.bitmover.com on Fri, Aug 23, 2002 at 05:39:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry.

Speaking about Bitkeeper, I have a feature request.
The view of changesets on bkbits is usefull, but the sorting does not
give the full picture.

Follow this example:
bk pull http://linux.bkbits.net/linux-2.5
- Do some editing
- Check in changes
- Test the changes a few days
- Submit the cset(s) to Linus
Linus do a bk pull from my repository

When accessing bkbits via the web interface, the canges are listed
sorted after the time I did the modifications, not when Linus actually 
did the bk pull, so they may be preceeded by maybe 100 cset's.

Is it possible somehow to sort the cset(s) according to the time they were
applied to the local tree, and not when they were originally committed?

	Sam
