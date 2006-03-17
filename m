Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932858AbWCQXHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbWCQXHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWCQXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:07:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932858AbWCQXHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:07:44 -0500
Date: Fri, 17 Mar 2006 15:07:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: mchehab@infradead.org
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 00/21] V4L/DVB fixes
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
Message-ID: <Pine.LNX.4.64.0603171505570.3826@g5.osdl.org>
References: <20060317205359.PS65198900000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, mchehab@infradead.org wrote:
>
> This patch series is also available under v4l-dvb.git tree at:
>         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> 
> Linus, please pull these from master branch.

Not this close before 2.6.16.

I'll happily take individual patches that come with some explanation for 
why they are really critical at this point, but I don't want to do a pull 
of what seems to be at least partly just cleanups.

		Linus
