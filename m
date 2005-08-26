Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVHZGbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVHZGbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHZGbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:31:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3286 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932525AbVHZGbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:31:36 -0400
Date: Fri, 26 Aug 2005 08:32:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7-rt1
Message-ID: <20050826063223.GE17783@elte.hu>
References: <20050825062651.GA26781@elte.hu> <1125006373.10901.11.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125006373.10901.11.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Wakeup race checking shouldn't trigger when interrupts are off. Here's 
> a fix.

thanks, applied.

	Ingo
