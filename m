Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVBTLtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVBTLtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 06:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVBTLtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 06:49:14 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:64505 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261818AbVBTLtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 06:49:10 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502192201380.14927@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
	 <1108870731.8413.163.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502192201380.14927@ppc970.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 20 Feb 2005 06:48:00 -0500
Message-Id: <1108900080.8413.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 22:51 -0800, Linus Torvalds wrote:

> Does a patch like this (instead of your version) work for you? It removes
> the Intel quirk entirely, and replaces it with the "if there's no
> resource, use the parent resource as the default fallback" code.

Hi Linus,

I live on the East coast so it's later for me than for you, so sorry
about not responding earlier.  I have to go to my daughter's gymnastics
meet today so I probably won't get to try any of this till tomorrow.

Thanks,


-- Steve


