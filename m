Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUGMXrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUGMXrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267239AbUGMXrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:47:14 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:26851 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267237AbUGMXrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:47:12 -0400
Subject: Re: [Nbd] [ANNOUNCE] Portable NBD server
From: Wouter Verhelst <wouter@grep.be>
To: nbd-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, misc@openbsd.org
In-Reply-To: <20040713174540.GA727@hexapodia.org>
References: <20040713174540.GA727@hexapodia.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Grep.be -- Grep the Internet ;-)
Message-Id: <1089762479.3236.7.camel@worldmusic>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 01:47:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op di 13-07-2004, om 19:45 schreef Andy Isaacson:
> Apologies for the cross-post, but this is relevant to all three lists.
> Please don't cross-post followups (unless they're relevant to several
> lists); obey the Reply-To or reply to me directly.
> 
> The NBD server in nbd-2.7.1 from nbd.sourceforge.net doesn't compile on
> non-Linux hosts,

Actually, it does; it compiles and runs on (at least) FreeBSD and The
Hurd. If it doesn't compile, I'd be happy to learn about it, and will
(most likely) incorporate any patches that might be relevant; the
intention, in any case, is for it to compile on anything resembling GCC
and some C library (although I'm quite aware that it probably doesn't
reach that goal at the moment, mostly since I didn't test on anything
else than the above two platforms, and Linux).

-- 
         EARTH
     smog  |   bricks
 AIR  --  mud  -- FIRE
soda water |   tequila
         WATER
 -- with thanks to fortune
