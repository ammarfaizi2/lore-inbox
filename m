Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVDFTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVDFTjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVDFTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:39:23 -0400
Received: from stingr.net ([212.193.32.15]:42892 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S262298AbVDFTjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:39:19 -0400
Date: Wed, 6 Apr 2005 23:39:11 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050406193911.GA11659@stingr.stingr.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Linus Torvalds:
> Ok,
>  as a number of people are already aware (and in some cases have been

Actually, I'm very disappointed things gone such counter-productive
way. All along the history, I was against Larry's opponents, but at
the end, they are right. That's pity. To quote vin diesel' character
Riddick, "there's no such word as friend", or something.

Anyway, seems that folks in Canonical was aware about it, and here's
the result of this awareness: http://bazaar-ng.org/
This need some testing though, along with really hard part - transfer
all history, nonlinear ... I don't know how anyone can do this till 1
Jul 2005, sorry :(

> PS. Don't bother telling me about subversion. If you must, start reading
> up on "monotone". That seems to be the most viable alternative, but don't
> pester the developers so much that they don't get any work done. They are
> already aware of my problems ;)

Monotone is good, but I don't really know limits of sqlite3 wrt kernel
case. And again, what we need to do to retain history ...


-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
