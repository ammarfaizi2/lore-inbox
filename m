Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTGAOgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTGAOgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:36:33 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:44999 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262153AbTGAOgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:36:32 -0400
Date: Tue, 1 Jul 2003 07:50:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030701145041.GA18394@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030621135812.GE14404@work.bitmover.com> <20030621190944.GA13396@work.bitmover.com> <20030622002614.GA16225@work.bitmover.com> <20030623053713.GA6715@work.bitmover.com> <20030625013302.GB2525@work.bitmover.com> <20030626231752.E5633@ucw.cz> <20030626212102.GA19056@work.bitmover.com> <1056711200.3174.23.camel@dhcp22.swansea.linux.org.uk> <20030627145727.GB18676@work.bitmover.com> <1056728645.3174.48.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056728645.3174.48.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know how to enable caching on a mylex AcceleRAID 170 (aka
DAC960) SCSI controller?  We've got the bkbits.net data mirrored at
rackspace.com but the controllers are read and write cache disabled.

I read the driver source and it doesn't offer this ability via the
/proc configuration space which is where I would have expected it.
Is this a bios only thing?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
