Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTI3W0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTI3W0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:26:08 -0400
Received: from [195.227.105.178] ([195.227.105.178]:49038 "EHLO
	SpeedMailer.intranet.fbn-dd.de") by vger.kernel.org with ESMTP
	id S261748AbTI3WZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:25:58 -0400
Date: Wed, 1 Oct 2003 00:24:34 +0200
From: Martin Pitt <martin@piware.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call traces due to lost IRQ
Message-ID: <20030930222433.GA610@donald.balu5>
References: <20030930154032.GA795@donald.balu5> <20030930112429.A722@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930112429.A722@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.21.0.1; VDF: 6.21.0.56
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am 2003-09-30 11:24 -0700 schrieb Chris Wright:
> * Martin Pitt (martin@piware.de) wrote:
> > Hi!
> > 
> > [1.] Kernel boot yields lost IRQ with some call traces
> 
> Can you try the following patch?

I just did, compiled and rebooted. Now it works perfectly, not a
single error or warning message. :-))

Thank you very much and have a nice day!

Martin
-- 
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de
