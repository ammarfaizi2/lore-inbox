Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWG3GCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWG3GCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWG3GCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:02:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751178AbWG3GCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:02:44 -0400
Date: Sat, 29 Jul 2006 23:02:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [PATCH 00/23] V4L/DVB fixes
In-Reply-To: <1154222716.27019.39.camel@praia>
Message-ID: <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
References: <20060725180311.PS54604900000@infradead.org> <1154222716.27019.39.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Jul 2006, Mauro Carvalho Chehab wrote:
> 
> Please pull these (and the other ones) from master branch at:
>         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

I get a _huge_ diffstat with

 135 files changed, 3056 insertions(+), 1562 deletions(-)

from this, so I _really_ don't want to pull them, especially as your 
previous version indicated just:

> >  38 files changed, 323 insertions(+), 155 deletions(-)

which is almost an order of magnitude less.

It's much too late to do this kind of big changes now.

		Linus
