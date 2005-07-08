Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVGHRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVGHRsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVGHRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:48:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262731AbVGHRsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:48:21 -0400
Date: Fri, 8 Jul 2005 13:48:15 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708174815.GA4884@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081047.07643.s0348365@sms.ed.ac.uk> <20050708114838.GA12272@elte.hu> <200507081842.53089.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081842.53089.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 06:42:53PM +0100, Alistair John Strachan wrote:
> > btw., which gcc version are you using?
> 
> Not the GCC version known to bloat stacks ;-)
> 
> 3.4.4, on both my machines. I'm not touching 4.x until 4.0.1 is released with 
> the miscompiled-code fixes.

GCC 4.0.x bloats stacks less than 3.4.4.
And, if you are looking for 4.0.1, it has been released yesterday.

	Jakub
