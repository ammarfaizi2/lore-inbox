Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTHYTzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTHYTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:55:54 -0400
Received: from www.13thfloor.at ([212.16.59.250]:10700 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262258AbTHYTzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:55:53 -0400
Date: Mon, 25 Aug 2003 21:56:05 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825195605.GD28525@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at> <20030825122906.79d755d4.rddunlap@osdl.org> <20030825204426.A11208@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030825204426.A11208@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 08:44:26PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 25, 2003 at 12:29:06PM -0700, Randy.Dunlap wrote:
> > Also see Ch. 10 of the LDD book:
> >   http://www.xml.com/ldd/chapter/book/ch10.html
> 
> Well, that chapter has some issue.  It talks of sparc64 when actually
> meaning a sparc32 userland on sparc64, and it missed the 2.6 merge of
> mips64 into mips as mips can now have either 32 or 64bit longs and
> pointers.

hmm, good to know :( ... isn't this tracked somewhere?
guess it would be an interesting table, especially regarding
the more exotic architectures like arm, cris, s390 ...

what do you think?

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
