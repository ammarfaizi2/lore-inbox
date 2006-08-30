Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWH3M7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWH3M7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWH3M7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:59:14 -0400
Received: from ns.suse.de ([195.135.220.2]:4305 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750945AbWH3M7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:59:13 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 14:59:14 +0200
User-Agent: KMail/1.9.3
Cc: Riley@williams.name, davej@redhat.com, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <p73y7t65z6c.fsf@verdi.suse.de> <20060830121845.GA351@1wt.eu>
In-Reply-To: <20060830121845.GA351@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301459.15008.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately, this situation is even more difficult for me, because it's
> getting very hard to track patches that get applied, rejected, modified or
> obsoleted, which is even more true when people don't always think about
> sending an ACK after the patch finally gets in. I already have a few pending
> patches in my queue waiting for an ACK that will have to be tracked if the
> persons do not respond, say, within one week. Otherwise I might simply lose
> them.

It shouldn't be that hard to check gitweb or git output occasionally
for the patches. You can probably even automate that.
 
> I think that the good method would be to :
>   - announce the patch
>   - find a volunteer to port it
>   - apply it once the volunteer agrees to handle it
> This way, no code gets lost because there's always someone to track it.

I can put that one into my tree for .19

-Andi

