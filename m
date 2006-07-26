Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWGZVzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWGZVzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWGZVzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:55:53 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:7349 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751178AbWGZVzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:55:52 -0400
Date: Wed, 26 Jul 2006 23:55:36 +0200
From: fork0@t-online.de (Alex Riesen)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
Message-ID: <20060726215536.GA6046@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1153929715.13509.12.camel@localhost.localdomain> <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: TJ2QaTZd8ebU8+UkXAgIQ-uI4j4c8rPbS4jkvH2XI1c7clfdFe8ysn
X-TOI-MSGID: f9bb9fe3-9fb0-40a0-a475-94e8af57b92e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds, Wed, Jul 26, 2006 19:07:07 +0200:
> In fact, if you want to play around with a git patch, this trivial one 
> should make git-fsck-objects create those lost-and-found entries 
> automatically if you give it the "--lost-n-found" flag.

there is git-lost-found already. Still, it somewhat expected of fsck
to do such things.

