Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVALLT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVALLT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVALLT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:19:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21395
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261159AbVALLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:19:25 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Edjard Souza Mota <edjard@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ilias Biris <xyz.biris@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <4d6522b9050112013123535a0b@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105477069.17853.126.camel@tglx.tec.linutronix.de>
	 <4d6522b9050112013123535a0b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 12:19:23 +0100
Message-Id: <1105528763.17853.215.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 11:31 +0200, Edjard Souza Mota wrote:
> propose a new selection mechanism. This misinterpretation is misleading the
> discussion of whether it may have som use in embedded devices or not.
> Even though, I believe that for PCs environment it has a great potential
> when you think that admins don't stay all the time in front of a computer.
> Once and while they also have a rest :). In these cases, instead of simply
> start ranking a deamon could dispatch a msg to her/him saying the system
> is approaching a red zone.

Pretty intriguing. Maybe the daemon waits for the answer mail then,
where the admin confirms to select the daemon as the preferrable victim
of oom. 

tglx


