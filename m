Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTDIUpO (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTDIUpN (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:45:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:61965 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263803AbTDIUpM (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:45:12 -0400
Date: Wed, 9 Apr 2003 21:56:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bk pull
Message-ID: <20030409215650.A10311@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200304091927.h39JRob0010157@napali.hpl.hp.com> <20030409203836.A9397@infradead.org> <16020.34678.824488.248372@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16020.34678.824488.248372@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Apr 09, 2003 at 01:49:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 01:49:58PM -0700, David Mosberger wrote:
> Sure, I too would like it if the kernel would always build
> out-of-the-box, but I don't think it's very realistic.  Even if I
> followed Linus's checkins on an hourly basis (no way in hell I'm ever
> gonna do that), there is always a chance that he'll accept a patch
> that will (perhaps subtly) break non-x86 platforms.

Hey, I didn't mean _always_ build out of the box :)  I'm much more
looking forward to 2.6.x releases I'd like to see just build for ia64.

> I'm working on) and the virtual mem_map support.  The latter I haven't
> pushed at all so far, mostly because I just haven't had the
> time/energy/interest to do so.  Also, I'm always optimistic someone
> else comes along to help with the work... ;-)

Well, I could try to help pushing some stuff.  OTOH pushing stuff I
don't understand is a bad idea.  Could you please explain e.g. the
mm/bootmem.c and mm/page_alloc.c changes?

