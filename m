Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVKJMWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKJMWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKJMWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:22:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28895 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750789AbVKJMWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:22:09 -0500
Date: Thu, 10 Nov 2005 13:21:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Beulich <JBeulich@novell.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: make trap information available to die handlers
Message-ID: <20051110122117.GA9500@elf.ucw.cz>
References: <4370AEE1.76F0.0078.0@novell.com> <4370E5C4.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511080853360.15288@shark.he.net> <4370E9A2.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511080912090.15288@shark.he.net> <4371BF59.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4371BF59.76F0.0078.0@novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 09-11-05 09:20:25, Jan Beulich wrote:
> >>> "Randy.Dunlap" <rdunlap@xenotime.net> 08.11.05 18:13:28 >>>
> >On Tue, 8 Nov 2005, Jan Beulich wrote:
> >
> >> >And the patch (attachment) also contains From:, but it's missing
> >> >a Signed-off-by: line.
> >>
> >> I looked at many ChangeLog entries (which supposedly get created
> from
> >> the abstract), and by far not all of them have the author listed
> both as
> >> From: and Singed-Off-By:, which made me think that either of the
> two
> >> should be sufficient (and I really can't see why the author
> information
> >> needs to appear twice).
> >
> >Tools can determined the From: part from your email, so it's
> >often safe to omit that part.
> >
> >The S-o-b part is required...
> 
> Strange. Andi Kleen specifically asked me to add From: to my patches...
> And I still can't see why the author of a patch wouldn't implicitly sign
> off on it.

Read Documentation/SubmittingPatches. s-o-b: means that patch is GPL.

								Pavel
-- 
Thanks, Sharp!
