Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265511AbSKFBvY>; Tue, 5 Nov 2002 20:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265509AbSKFBvY>; Tue, 5 Nov 2002 20:51:24 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:18882 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265511AbSKFBvX>; Tue, 5 Nov 2002 20:51:23 -0500
Date: Tue, 5 Nov 2002 23:57:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Eff Norwood <enorwood@effrem.com>
cc: linux-kernel@vger.kernel.org, Kevin Corry <corryk@us.ibm.com>,
       <evms-devel@lists.sourceforge.net>,
       <evms-announce@lists.sourceforge.net>
Subject: RE: [Evms-devel] EVMS announcement
In-Reply-To: <CFEAJJEGMGECBCJFLGDBIEEBCHAA.enorwood@effrem.com>
Message-ID: <Pine.LNX.4.44L.0211052355510.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Eff Norwood wrote:

> So, having EVMS not included in the kernel was the decision they wanted
> to make?

Not having the kernel part of EVMS doesn't mean EVMS isn't
available to users. EVMS can get a lot of the functionality
using device mapper.

> If not, then I propose you be a little more reasonable and think about
> what this decision does to all the work thus far put into EVMS.

The work put into EVMS this far is maybe 20% of the work that
maintaining EVMS would cost once it's in the kernel.

Developing code is nowhere near as much work as maintaining it
indefinately. Using the device mapper framework makes a lot of
sense from many points of view.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

