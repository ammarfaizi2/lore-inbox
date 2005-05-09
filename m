Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVEIIBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVEIIBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVEIIBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:01:42 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:30890 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S263074AbVEIIBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:01:38 -0400
Message-ID: <427F1A99.58BCCB88@tv-sign.ru>
Date: Mon, 09 May 2005 12:08:57 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407> <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > Daniel Walker wrote:
> > >
> > > Make a patch .
> >
> > Will do. However, I'm unfamiliar with Ingo's tree, so I
> > can send only new plist's implementation.
> 
> i've uploaded my latest tree to:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 

Ok, I'll try to do it. Do you have any comments/objections to
"[RFC][PATCH] alternative implementation of Priority Lists", see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111547290706136
?

Oleg.
