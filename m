Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVIKWEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVIKWEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVIKWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:04:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750954AbVIKWEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:04:38 -0400
Date: Sun, 11 Sep 2005 15:04:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCHES] kbuild fixes
In-Reply-To: <20050911214850.GA2177@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0509111503090.3242@g5.osdl.org>
References: <20050911214850.GA2177@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> 
> I've started suing the alternate format as you described.
> So I cannot pull from that respository myself.
> http: + rsync: failed?

If you first do a "git fetch linus" to fetch all the objects in my
archive, then you should be able to pull from the cleaned-up archive fine, 
simply because that archive is missing only bits that you already had 
locally (and thus wouldn't fetch anyway).

> I hope you know a few smart tricks.

That's a very stupid trick, but it should work for you ;)

		Linus
