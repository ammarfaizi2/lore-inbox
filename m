Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbTF0WDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTF0WCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:02:50 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:3524 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264860AbTF0WBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:01:12 -0400
Date: Fri, 27 Jun 2003 15:15:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       nick@snowman.net, Larry McVoy <lm@bitmover.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030627221512.GB11252@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
	nick@snowman.net, Larry McVoy <lm@bitmover.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627221214.GA11252@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627221214.GA11252@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 03:12:14PM -0700, Larry McVoy wrote:
> Well, I almost had everything backed up to the new rackspace server
> and we crashed.  We're in fsck now.  I think the machine room overheated.

Oh, yeah, in the meantime for the repos which made it to the backup machine,
you can get them like so:

	OLD:	bk://project.bkbits.net/repo
	NEW:	bk://rack2.bitmover.com/$C/project/repo

where
	$C	first letter of your project name

Not all of them are there, we were part way through the "l"s which is the
biggest directory (you guys need to be more imaginative in your naming).
All the other letters should be there though, so I want to hear about it
if you are a [a-km-z] project and you can't pull your data.  Pushes don't
work.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
