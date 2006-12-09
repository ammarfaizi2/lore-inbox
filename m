Return-Path: <linux-kernel-owner+w=401wt.eu-S936581AbWLIJ0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936581AbWLIJ0l (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936595AbWLIJ0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:26:41 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:44050 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936581AbWLIJ0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:26:40 -0500
Date: Sat, 9 Dec 2006 10:26:39 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061209092639.GA15443@torres.l21.ma.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4578465D.7030104@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 11:50:37AM -0500, Phillip Susi wrote:
> Marc Haber wrote:
> >I went back to 2.6.18.3 to debug this, and the system ran for three
> >days without problems and without corrupting
> >/var/cache/apt/pkgcache.bin. After booting 2.6.19 again, it took three
> >hours for the file corruption to show again.
> >
> >I do not have an idea what could cause this other than the 2.6.19
> >kernel.
> <snip>
> >I'll happily deliver information that might be needed to nail down
> >this issue. Can anybody give advice about how to solve this?
> 
> I'd say start git bisecting to track down which commit the problem 
> starts at.

Unfortunately, I am lacking the knowledge needed to do this in an
informed way. I am neither familiar enough with git nor do I possess
the necessary C powers.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
