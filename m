Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbTE1Jkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTE1Jkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:40:42 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:23303 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264633AbTE1Jkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:40:41 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 11:53:15 +0200
User-Agent: KMail/1.5.2
Cc: manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de> <20030528093654.GA20687@linalco.com>
In-Reply-To: <20030528093654.GA20687@linalco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305281153.15317.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 11:36, Ragnar Hojland Espinosa wrote:

Hi Ragnar,

> Actually it just happens in the fixing stage when burning prebuilt iso
> images from the hard disk (same IDE channel as the burner, 2.4.20)
> Having a completely frozen machine under X was quite panic inducing ;)
That's a problem of IDE itself. I still say IDE is broken by design ;-)

> A friend told me they also get regular "pauses" when quitting from
> vmware.
Yep, occurs also with my machines.

ciao, Marc

