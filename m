Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVAQFWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVAQFWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVAQFWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:22:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:56591 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262693AbVAQFWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:22:42 -0500
Date: Mon, 17 Jan 2005 06:10:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>, linux-crypto@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
Message-ID: <20050117051045.GN7048@alpha.home.local>
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EB3E7E.7070100@tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

On Sun, Jan 16, 2005 at 11:26:38PM -0500, Bill Davidsen wrote:
 
> Is this eventually going in the mainline kernel? I'd like to use it, but 
> if I'm going to have to maintain my own crypto kernels indefinitely this 
> probably isn't the one for me.

On a side note, I would say that this one is not particularly difficult to
apply, and Jari often includes up to date patches. Admittedly, when you want
to stick to an old kernel for a long time, it might become difficult. I've
been doing this for about 2 years now, and I cannot say that this one caused
me any nightmares yet. However, if it went into mainline, it would be better
of course !

Cheers,
Willy

