Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVBFNJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVBFNJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVBFNJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:09:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9643 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261216AbVBFNHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:07:21 -0500
Date: Sun, 6 Feb 2005 13:06:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206130650.GA32015@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, drepper@redhat.com
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206130152.GH30109@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:01:52PM +0100, Andi Kleen wrote:
> > correct,
> > http://lists.ximian.com/archives/public/mono-list/2004-June/021592.html
> > 
> > that fixes mono instead
> 
> Silent breakage => bad.

silent breakage for newly compiled buggty and non-portable code.

Still not nice but certainly tolerable.  

