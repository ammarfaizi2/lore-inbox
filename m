Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271549AbTGQSUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271542AbTGQSTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:19:36 -0400
Received: from user-10cm126.cable.mindspring.com ([64.203.4.70]:56071 "HELO
	cia.zemos.net") by vger.kernel.org with SMTP id S271553AbTGQSRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:17:12 -0400
Date: Thu, 17 Jul 2003 11:32:56 -0700 (PDT)
From: Gorik Van Steenberge <gvs@cia.zemos.net>
To: James Simmons <jsimmons@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cursor dissapears after setfont
In-Reply-To: <Pine.LNX.4.44.0307171848270.10255-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.50L0.0307171129080.9840-100000@cia.zemos.net>
References: <Pine.LNX.4.44.0307171848270.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Jul 2003, James Simmons wrote:

>
> > I recently compiled 2.6.0-test1 and noticed that I didn't have a cursor on
> > any tty but tty1. After testing some things I found out that the cursors
> > dissapear after "setfont -v default8x9.psfu.gz". Also, the cursor does not
> > dissapear on the tty that called setconfig. I also had this problem in
> > 2.5.70. AFAIK I'm using the latest kbd.
> >
> > I am not sure what info I should supply that would be relevant to this
> > issue.
>
> What is your configuration so I can replicate this problem?
>
>

I uploaded my .config here: http://unixclan.net/~gvs/kernconfig
