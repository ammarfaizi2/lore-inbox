Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULMRTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULMRTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbULMRRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:17:11 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:23949 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbULMRNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:13:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CWHSx6+u/Rr291cPoxiBACOy0+teckqis6RV8Gf4/DJ2D/RNq/4Fw16OJf1MoLM11bs++YfNE2sf+IH77BBYVhqEZg9BI8gvIy8tN+g2j0o2JidppNZj/aPiDZpJneWzuOhM30GrLE9Tk9zjciJeTLXSZmBfPeW0JB/RQDPRkxE=
Message-ID: <3fff1a7104121309131df25f97@mail.gmail.com>
Date: Mon, 13 Dec 2004 19:13:54 +0200
From: Patrick <nawtyness@gmail.com>
Reply-To: Patrick <nawtyness@gmail.com>
To: Eric Sandeen <sandeen@sgi.com>
Subject: Re: Unknown Issue.
Cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <41BDCB8F.5080902@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2E314DE03538984BA5634F12115B3A4E01BC4175@email1.mitretek.org>
	 <41BDCB8F.5080902@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> Patrick, can you reproduce on a non-gentoo kernel?  That'd be the first
> step for this audience.

I've not tried to reproduce it on a non-gentoo kernel as the original
one that i had the problem was a vanilla kernel ;) ( as i know your
fondness of gentoo's patch-o-lotic )

I've been abusing the box the entire day with FreeBSD, the same mysql
config and version of the mysqld as well as the same operations ( and
some more ... serious ones ( e.g. forkbomb, iozone, etc. ) and no
problem's.

There were no messages in the log, and nothing in kmesg. Anything else
i could try ? Also, as far as i know i was running kernel 2.6.10_rc3
and i'd reinstalled the box twice with new XFS filesystems both times.

P
