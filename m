Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267420AbTGHOup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbTGHOup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:50:45 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:5895 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267420AbTGHOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:50:44 -0400
Date: Tue, 8 Jul 2003 16:05:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys gpl code [OT]
Message-ID: <20030708160519.A11679@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kernel <linux-kernel@vger.kernel.org>
References: <1057663858.3959.41.camel@miyazaki> <20030708144509.GE20605@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708144509.GE20605@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jul 08, 2003 at 04:45:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 04:45:10PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2003-07-08 12:30:58 +0100, Matthew Hall <matt@ecsc.co.uk>
> wrote in message <1057663858.3959.41.camel@miyazaki>:
> > Hi lkml,
> > 	I don't know if anyone's noticed, but Linksys have opened up and
> > released their code.
> > 
> > http://www.linksys.com/support/gpl.asp
> > 
> > Don't know if it satisfies the gpl; i'm currently downloading the stuff
> > to see what's different from the release sources.
> 
> I downloaded that kernel.tgz and diff'ed it out - it's a *hugh* patch
> removing tons of comments and #if 0 ... #endif parts. That makes it
> more complicated to find the "interesting" parts for us, but also it
> will get hard for them to ever port that changes over to 2.4.current...

Can you upload it somewhere or is it too big for that?

