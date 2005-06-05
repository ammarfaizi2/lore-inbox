Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFECjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFECjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 22:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFECjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 22:39:14 -0400
Received: from mail.dslreports.com ([209.123.192.187]:35216 "EHLO
	mail.dslr.net") by vger.kernel.org with ESMTP id S261443AbVFECjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 22:39:08 -0400
Subject: Re: [SATA] libata-dev queue updated
From: Drew Winstel <raw@dslr.net>
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <87k6l9k0aa.fsf@stark.xeocode.com>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	 <42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
	 <42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>
	 <20050604191958.GA13111@havoc.gtf.org>  <87k6l9k0aa.fsf@stark.xeocode.com>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 21:40:03 -0500
Message-Id: <1117939204.26775.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-04 at 22:25 -0400, Greg Stark wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > On Sat, Jun 04, 2005 at 03:15:24PM -0400, Greg Stark wrote:
> > > So my question is, if I did tackle this riddle trail and figured out how to
> > > fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
> > > just start working? Or would it just confuse the SMART tools until they're
> > > updated? Or would it just crash my machine?
> > 
> > SMART should just start working.  It adds the ioctls that existing smartd
> > and hdparm already know about.
> 
> So, uh, where do I get git? Where is your "git repository" and Linus' "git
> repository" and how do I set that up?
> 
> Or, at least, where do I find all this info?
> 
> 
Your best bet is probably to read Jeff's short git how-to at
http://kerneltrap.org/node/5196 and just about every other LKML-oriented
site.  Hopefully that gives you a good start.

Drew

