Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWIKVqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWIKVqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIKVqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:46:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:53389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964888AbWIKVqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:46:45 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
Date: Mon, 11 Sep 2006 22:48:11 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609112220.01032.ak@suse.de> <4505D709.9020409@goop.org>
In-Reply-To: <4505D709.9020409@goop.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609112248.12517.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 23:37, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > On Monday 11 September 2006 07:25, Ingo Molnar wrote:
> >> Jeremy,
> >>
> >> could you back out Andi's patch and try the patch below, does it fix the
> >> crash too?
> >
> > I folded it into the original patch now thanks
>
> Ingo's patch was wrong.  Here's an update:

Fixed too thanks

-Andi
