Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWCHTKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWCHTKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWCHTKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:10:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51884 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932355AbWCHTKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:10:53 -0500
Subject: Re: [Updated]: How to become a kernel driver maintainer
From: Arjan van de Ven <arjan@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
References: <1136736455.24378.3.camel@grayson>
	 <1136756756.1043.20.camel@grayson>
	 <1136792769.2936.13.camel@laptopd505.fenrus.org>
	 <1136813649.1043.30.camel@grayson>
	 <1136842100.2936.34.camel@laptopd505.fenrus.org>
	 <1141841013.24202.194.camel@grayson>
	 <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 20:10:46 +0100
Message-Id: <1141845047.12175.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > about the change to start discussion.
> >
> Perhaps add a bit of text here about integrating patches send to you,
> as maintainer of the driver, by random people.

it's not integrating.
It's reviewing and passing on for merge ;)
fundamental difference. You don't "own" the driver in the tree. You just
keep it nice and shiny and clean. Best done by blessing patches, and by
developing in "patches" not "new codebase". The entire "new codebase"
thinking is the problem with CVS-think. Think in patches (once merged),
not in code/tree.


