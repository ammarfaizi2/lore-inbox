Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWGMMNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWGMMNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWGMMNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:13:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4288 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751489AbWGMMNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:13:31 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Date: Thu, 13 Jul 2006 14:13:23 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org
References: <20060630014050.GI19712@stusta.de> <20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org>
In-Reply-To: <20060712185103.f41b51d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131413.24228.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 03:51, Andrew Morton wrote:
> On Wed, 12 Jul 2006 23:07:32 +0200
>
> Ingo Molnar <mingo@elte.hu> wrote:
> > Despite good resons to apply the patch, it has not been applied yet,
> > with no explanation.
>
> I queued the below.  Andrea claims that it'll reduce seccomp overhead to
> literally zero.

Chuck's patch - possibly with Linus' rename - is better.

-Andi

