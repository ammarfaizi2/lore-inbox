Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTFREVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 00:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbTFREVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 00:21:37 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:30688 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264766AbTFREVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 00:21:36 -0400
Date: Tue, 17 Jun 2003 21:35:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
Message-ID: <20030618043527.GA21723@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20030615002153.GA20896@work.bitmover.com> <20030618013940.GA19176@work.bitmover.com> <3EEFC6A3.5010406@zytor.com> <20030618011455.GF542@hopper.phunnypharm.org> <bcooor$pbj$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcooor$pbj$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 09:11:07PM -0700, H. Peter Anvin wrote:
> Followup to:  <20030618011455.GF542@hopper.phunnypharm.org>
> By author:    Ben Collins <bcollins@debian.org>
> In newsgroup: linux.dev.kernel
> > > 
> > > I have no problem setting up CNAMEs in kernel.org if people are OK with
> > > it.  Setting up actual servers is another matter.
> > 
> > CNAMES on kernel.org would be perfect.
> > 
> 
> So right now cvs, svn and bk all -> kernel.bkbits.net?

We only need cvs and svn; bk is hosted at linux.bkbits.net.

If someone else wants to either host or provide a hot backup for either of
these, that's cool with us.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
