Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTFRDYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 23:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTFRDYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 23:24:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:22239 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265059AbTFRDYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 23:24:24 -0400
Date: Tue, 17 Jun 2003 20:38:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
Message-ID: <20030618033816.GB6552@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030615002153.GA20896@work.bitmover.com> <bcneo1$osd$1@cesium.transmeta.com> <20030618013940.GA19176@work.bitmover.com> <3EEFC6A3.5010406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEFC6A3.5010406@zytor.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 06:55:47PM -0700, H. Peter Anvin wrote:
> Larry McVoy wrote:
> > 
> > It seems to me that kernel.org is the right place but if hpa is too busy
> > (which I understand and respect) then we need to come up with some sort of
> > domain which is unused, simple, and memorable.  I'm aware of the levels of
> > distrust people have for bitmover but we could pay for it and run the DNS
> > servers and let some set of community agreed on people manage the DNS entries
> > if that makes people feel safe.
> > 
> 
> I have no problem setting up CNAMEs in kernel.org if people are OK with
> it.  Setting up actual servers is another matter.

I think CNAMEs are all that we need now.  BitMover and Penguin Computing
will host it for the time being and if we cross over to the dark side
someone else can step forward and host it and all you need to do is redo
the CNAMEs.  

We do need to advertise the "URLs" for the CVS tree and the SVN tree and 
the BK trees as well I suppose.  Is that a Gooch/FAQ thing?  Richard, you
still out there?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
