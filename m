Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTGSD0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 23:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTGSD0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 23:26:24 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:24455 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S270486AbTGSD0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 23:26:05 -0400
Date: Sat, 19 Jul 2003 11:40:59 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] O7int for interactivity
Message-ID: <20030719034059.GE10120@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <200307190210.49687.kernel@kolivas.org> <20030718230717.GG2289@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718230717.GG2289@matchmail.com>
X-Operating-System: Linux 2.6.0-test1-mm1+o6.1int
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Mike Fedyk">
> On Sat, Jul 19, 2003 at 02:10:49AM +1000, Con Kolivas wrote:
> > Here is an update to my Oint patches for 2.5/6 interactivity. Note I will be 
> > away for a week so bash away and abuse this one lots and when I get back I can 
> > see what else needs doing. Note I posted a preview earlier but this is the formal
> > O7 patch (check the datestamp which people hate in the naming of my patches).
> > I know this is turning into a marathon effort but... as you're all probably aware
> > there is nothing simple about tuning this beast. Thanks to all the testers and
> > people commenting; keep it coming please.
> 
> Is this on top of 06 or 06.1?

His patches are usually on top of the previous patch,
so if you applied O6int, apply O6.1int on it, then O7int on O6.1int.
But do read his readme file when you download it.

Eugene
