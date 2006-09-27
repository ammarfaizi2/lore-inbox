Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWI0HMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWI0HMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWI0HMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:12:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:15589 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932448AbWI0HMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:12:12 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: x86/x86-64 merge for 2.6.19
Date: Wed, 27 Sep 2006 09:11:22 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
References: <200609261244.43863.ak@suse.de> <20060926224114.5ca873ec.akpm@osdl.org>
In-Reply-To: <20060926224114.5ca873ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270911.22437.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 07:41, Andrew Morton wrote:
> On Tue, 26 Sep 2006 12:44:43 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> >       i386: Remove lock section support in semaphore.h
> 
> This change turns my x86_32 Vaio into a brick about half a second into
> bootup.  Screen goes black and the fan goes all whirry.

Oops. Sorry. I thought I had commented it out, but it sneaked back
in when I had to regenerated the tree.

> 
> It's a bit of a mystery why this well-reported bug was merged, but let us
> move on..

That was my fault clearly.
 
-Andi
