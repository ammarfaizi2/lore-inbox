Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTIAQ1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbTIAQ1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:27:53 -0400
Received: from dns.communicationvalley.it ([212.239.58.133]:39821 "HELO
	dns.communicationvalley.it") by vger.kernel.org with SMTP
	id S262898AbTIAQ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:27:51 -0400
From: biker@villagepeople.it
Organization: Communication Valley SpA
To: linux-kernel@vger.kernel.org
Subject: Re: pl2303 + uhci oops
Date: Mon, 1 Sep 2003 18:27:50 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011827.50331.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Using a pl2303-based usb->serial adaptor with the uhci driver always ends 
> > with a oops.
 
> Use 2.6.0-testX - it's fixed there:) I'm successfully using a GPS
> receiver based on a pl2303. This one if from www.lact.de (ebay'ed).
 
> MfG, JBG
 
This is good, but since 99% of the people is still using 2.4.x, it would be 
nice if it was fixed there too... ^_^
BTW, I'm very willing to help by providing any additional information that 
might be useful to solve the problem.

Take care,
Silla

