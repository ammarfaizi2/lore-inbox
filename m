Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132433AbRCZM62>; Mon, 26 Mar 2001 07:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRCZM6I>; Mon, 26 Mar 2001 07:58:08 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:23314 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132433AbRCZM6C>; Mon, 26 Mar 2001 07:58:02 -0500
Date: Mon, 26 Mar 2001 13:39:07 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch, take 2
In-Reply-To: <200103260955.f2Q9tfo14568@snark.thyrsus.com>
Message-ID: <Pine.LNX.3.96.1010326133257.7071A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Eric S. Raymond wrote:
> (2) Fix up 20 cris-architecture configuration symbols lacking a CONFIG_
>     prefix, so they obey CML1/CML2 conventions and can be detected by
>     `make dep', also static-analysis tools and consistency checkers.
>     This is a BUG FIX in CML1.

No need for you to fret on this; it's partly fixed in the version in
Alan's tree and the rest will be cleaned up in our next update.

-Bjorn

