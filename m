Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWF1Ub5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWF1Ub5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWF1Ub5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:31:57 -0400
Received: from mail.suse.de ([195.135.220.2]:3715 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751418AbWF1Ub4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:31:56 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] x86_64: Move export symbols to their C functions
Date: Wed, 28 Jun 2006 22:31:44 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606261902.k5QJ2R93008443@hera.kernel.org> <20060628195632.GH23396@redhat.com> <20060628201348.GI23396@redhat.com>
In-Reply-To: <20060628201348.GI23396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606282231.44938.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 22:13, Dave Jones wrote:
> On Wed, Jun 28, 2006 at 03:56:32PM -0400, Dave Jones wrote:
>  > On Wed, Jun 28, 2006 at 09:52:20PM +0200, Andi Kleen wrote:
>  >  > 
>  >  > > These two exports were never re-added, which broke modular oprofile.
>  >  > 
>  >  > Everybody and their dog sent patches for that by now and I assume
>  >  > Linus already merged Andrew's version
>  > 
>  > Ah, didn't see them, and my tree seems to be stale.
>  > Yes, looks fixed.
> 
> Actually, I take that back, I was looking at the wrong tree (again).
> It's not fixed in Linus tree yet in a git pull from a few minutes ago.

At least Andrew has already sent the patch. I assume it will
get in if it hasn't already.

-Andi
