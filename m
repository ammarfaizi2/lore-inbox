Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTG1NHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269423AbTG1NHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:07:53 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:23048 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267952AbTG1NHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:07:52 -0400
Date: Mon, 28 Jul 2003 14:23:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update 0.9.6
Message-ID: <20030728142306.A9127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jaroslav Kysela <perex@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030728134359.A2558@infradead.org> <Pine.LNX.4.44.0307281451220.28950-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307281451220.28950-100000@pnote.perex-int.cz>; from perex@suse.cz on Mon, Jul 28, 2003 at 03:17:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 03:17:24PM +0200, Jaroslav Kysela wrote:
> But the changesets are really great, so I am thinking to switch the ALSA 
> repository from CVS to BK soon. It will help to propagate changes better.

Thanks, that would be a lot nicer.  With cvsps or similar tools it should
be possible to do a CVS checking -> BK cset conversion, too.  I did
something similar for a SGI-internal RCS-based SCM.

