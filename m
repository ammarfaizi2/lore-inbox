Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264214AbTICWld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTICWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:41:32 -0400
Received: from mail.webmaster.com ([216.152.64.131]:21974 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264214AbTICWl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:41:26 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Stuart MacDonald" <stuartm@connecttech.com>
Cc: <root@chaos.analogic.com>, "'James Clark'" <jimwclark@ntlworld.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Wed, 3 Sep 2003 15:41:02 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEMAGDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1062601073.19058.70.camel@dhcp23.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mer, 2003-09-03 at 15:36, Stuart MacDonald wrote:
> > If the MODULE_LICENSE() macro is what determines taint, what's to
> > prevent a company from compiling their driver in their own kernel tree
> > with that macro and releasing it binary-only? Wouldn't that module
> > then be taint-free?

> They would be representing their module is GPL when its not, obtaining
> services by deceving people (3rd party support) and if they used _GPL
> symbols probably violating the DMCA by bypassing a digital rights
> system.

	Holy crap! You've totally pegged my hypocrisy meter.

	It is an outright blatant violation of the GPL to build use limitations
into GPL'd works and then use the DMCA to prevent people from removing or
bypassing those limitations.

	Next I'm going to add some new features to Linux and my code will check for
a license certificate before it runs. I'll use the DMCA to protect the
license check but I'll distribute the source code just like the GPL requires
me to.

	No, the GPL does not require derived works to be GPL'd. No, the GPL does
not allow you to impose additional usage restrictions and use the DMCA to
prohibit people from modifying the code to use it the way they want.

	DS


