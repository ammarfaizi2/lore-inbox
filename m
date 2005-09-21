Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVIUSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVIUSKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVIUSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:10:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42901 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751346AbVIUSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:10:19 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, pavel@suse.cz, len.brown@intel.com,
       drzeus-list@drzeus.cx, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, masouds@masoud.ir,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921104615.2e8dd7d5.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 21 Sep 2005 12:08:24 -0600
In-Reply-To: <20050921104615.2e8dd7d5.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 21 Sep 2005 10:46:15 -0700")
Message-ID: <m1ll1qcmzr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> I'm doin OK.

Good to hear.

> Patch volume isn't a problem wrt the simple mechanics of handling them. 
> The problem we have at present is lack of patch reviewing bandwidth.  I'll
> be tightening things up in that area.  Relatively few developers seem to
> have the stomach to do a line-by-line through large patches, and it would
> be nice to refocus people a bit on that.  Christoph's work is hugely
> appreciated, thanks.
>
> Famous last words, but the actual patch volume _has_ to drop off one day. 
> In fact there doesn't seem to much happening out there wrt 2.6.15.

Due to changes coming through git or that there will simply be fewer
things that need to be patched?

As for 2.6.15 I know I have patches in the queue that I intend to send
out later this week, which probably count.  I wonder if other developers
are similar.  

Eric
