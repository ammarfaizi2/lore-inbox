Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVAXPTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVAXPTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVAXPTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:19:09 -0500
Received: from david.siemens.de ([192.35.17.14]:44074 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id S261521AbVAXPTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:19:06 -0500
From: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>
Organization: Siemens AG
To: linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Date: Mon, 24 Jan 2005 16:18:54 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241618.54769.christoph.stueckjuergen@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 2002-09-04 at 12:50, Roy Sigurd Karlsbakk wrote: 
> > hi 
> > 
> > I just read in the OS X.2 technote 
> >  
(http://developer.apple.com/technotes/tn2002/tn2053.html#TN001016) 
> > that
> > they're writing the panic dump to nvram. 
> > 
> > Is it hard to implement this on Linux? 

 > Its been done years ago. However on a PC you basically have no 
free 
 > nvram so its not terribly useful there. 
If it has been done years ago, are there patches also for 2.6 
kernels available?

Christoph 
