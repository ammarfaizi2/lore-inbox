Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVALMMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVALMMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVALMMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:12:24 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:16990 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261173AbVALMMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:12:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G//1jJcYShw6b72LxUKY2eawqG+KWU36Bzk6fBvgmlfmeKXKf8sVCM7+NkPMMcHQdzrpx3iR4bMl8nAzMafGpKzXUVPW0JcelJcDjMTPOSPl8ARfd2JxBmutzHzw8gjHFZcdWzDxocgYAOyqxcQmlHsQpqBTeXVohWW74idrKcw=
Message-ID: <4d6522b905011204125c43c4fe@mail.gmail.com>
Date: Wed, 12 Jan 2005 14:12:00 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: tglx@linutronix.de
Subject: Re: User space out of memory approach
Cc: LKML <linux-kernel@vger.kernel.org>, Ilias Biris <xyz.biris@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105528763.17853.215.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105477069.17853.126.camel@tglx.tec.linutronix.de>
	 <4d6522b9050112013123535a0b@mail.gmail.com>
	 <1105528763.17853.215.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005 12:19:23 +0100, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 2005-01-12 at 11:31 +0200, Edjard Souza Mota wrote:
> > propose a new selection mechanism. This misinterpretation is misleading the
> > discussion of whether it may have som use in embedded devices or not.
> > Even though, I believe that for PCs environment it has a great potential
> > when you think that admins don't stay all the time in front of a computer.
> > Once and while they also have a rest :). In these cases, instead of simply
> > start ranking a deamon could dispatch a msg to her/him saying the system
> > is approaching a red zone.
> 
> Pretty intriguing. Maybe the daemon waits for the answer mail then,
> where the admin confirms to select the daemon as the preferrable victim
> of oom.
> 
> tglx

Hi,

Not worth commenting this "intriguing" idea.

Let's wait test results and Alan's answers to Ilias interpretation.

br

Edjard


-- 
"In a world without fences ... who needs Gates?"
