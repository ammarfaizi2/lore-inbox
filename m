Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKYSJx>; Sun, 25 Nov 2001 13:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280958AbRKYSJo>; Sun, 25 Nov 2001 13:09:44 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:35086 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S280954AbRKYSJd>;
	Sun, 25 Nov 2001 13:09:33 -0500
Date: Sun, 25 Nov 2001 19:07:37 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Dominik Kubla <kubla@sciobyte.de>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011125151543.57a1159c.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0111251859150.13294-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Stephan von Krawczynski wrote:

> The "problem" effectively arises from _fast_ releasing "stable" versions. I
> tend to think there should be a slowdown, not a speedup in stable releases,
> just because the weird bugs we saw lately were all found shortly after release.

True, but 2.4.15 should have been renamed 2.4.15-dontuse as soon as the
corruption bug was discovered, even if there is no 2.4.16 available.  The
important thing is not to get a new version out quickly, but to prevent
spreading of the bad version.  IMHO, of course...

/Tobias

