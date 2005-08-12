Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVHLACo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVHLACo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 20:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHLACo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 20:02:44 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:33240 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932251AbVHLACn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 20:02:43 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Tim Yamin <plasmaroo@gentoo.org>, Tavis Ormandy <taviso@gentoo.org>
Subject: Re: [patch 4/8] [PATCH] Update in-kernel zlib routines
References: <20050811225445.404816000@localhost.localdomain>
	<20050811225626.233013000@localhost.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Aug 2005 02:01:08 +0200
In-Reply-To: <20050811225626.233013000@localhost.localdomain>
Message-ID: <m3acjodnwb.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> -stable review patch.  If anyone has any  objections, please let us know.
> ------------------
> 
> a) http://sources.redhat.com/ml/bug-gnu-utils/1999-06/msg00183.html

Why does this 6 year old bug have to be fixed in the 2.6.12 stable
series? Doesn't the patch violate this stable series rule?

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)

Maybe the motivation was just missing from the patch description?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
