Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbVCKFpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbVCKFpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVCKFll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:41:41 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:10813 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263201AbVCKFje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:39:34 -0500
Date: Fri, 11 Mar 2005 06:40:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] kbuild updates
Message-ID: <20050311054027.GA8374@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050310215803.GA18044@mars.ravnborg.org> <20050310223218.GC3205@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310223218.GC3205@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this is the same version as in 2.6.11-mm2 (you didn't offer a GNU 
> patch so that I could check it), the following is still present:
> 
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/1507.html

Thanks Adrian, I forgot about that one.
It is now fixed and pushed to bk://linux-sam.bkbits.net/kbuild

	Sam
