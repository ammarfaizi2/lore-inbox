Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTDXIkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbTDXIkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:40:05 -0400
Received: from [203.199.93.15] ([203.199.93.15]:21509 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id S261885AbTDXIkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:40:02 -0400
From: "ramands" <ramands@indiatimes.com>
Message-Id: <200304240813.NAA23499@WS0005.indiatimes.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-newbie@vger.kernel.org>
Reply-To: "ramands" <ramands@indiatimes.com>
Subject: Re: Re: OOPS in Kmalloc
Date: Thu, 24 Apr 2003 14:15:06 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello randy 
as i am new to kernel level programing 
i do not know how to decode a oops . could you tell me how to do it 
i will mail the exact oops messages in next mail 
right now i am debugging by using printk only 

raman 
"Randy.Dunlap" wrote:



&gt; Hello,
&gt; i am getting OOPS in Kmalloc .
&gt;
&gt; void **data;
&gt; qset = 1000;
&gt;
&gt; dptr-&gt;data = kmalloc(qset * sizeof(char *), GFP_KERNEL);
&gt;
&gt; what could the possible the cause of the error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
As I am so fond of saying, it's almost always correct to indicate what
kernel version one if referring to in a problem report.

Please decode the oops output and post it here.

~Randy






Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy The Best In BOOKS at http://www.bestsellers.indiatimes.com

Bid for for Air Tickets @ Re.1 on Air Sahara Flights. Just log on to http://airsahara.indiatimes.com and Bid Now !

