Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUEKGlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUEKGlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUEKGkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:40:53 -0400
Received: from holomorphy.com ([207.189.100.168]:16560 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262071AbUEKGhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:37:32 -0400
Date: Mon, 10 May 2004 23:37:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511063720.GA1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511072132.B12187@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511072132.B12187@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 05:14:13PM -0700, Andrew Morton wrote:
>> If someone had done the kernel and userspace work 6-12 months ago then
>> sure, we wouldn't be in this situation.

On Tue, May 11, 2004 at 07:21:32AM +0100, Christoph Hellwig wrote:
> Well, the question is why did those folks who care about it (Oracle it
> seems) not do it 6-12 month ago?
> This oh shit oracle needs it we need to come up with a hack mentality
> sucks big time.  If oracle (or $ISV/$IHV) they should send patches in
> time so we can discuss it.  In fact these patches don't even come from
> Oracle but from Intel which shows something is seriously wrong with all
> this.

There were a combination of factors contributing to this, including
release-oriented efforts distracting ppl from 2.6 contributions,
disagreements outside kernel.org as to how to resolve this that
resulted in divergent solutions instead of any kind of agreement on a
solution, and so on.

IMHO the only opportunity for convergence etc. is this kind of flamewar
plus actual code rolling in atop it. I'm in the midst of some upheaval
(e.g. on the road plus having getting X running on laptop issues) so
please be patient while I get set up to write whatever code people want
to talk about for whatever alternative solutions they want implemented.

Thanks.


-- wli
