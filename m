Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVEMOOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVEMOOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVEMONB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:13:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43476 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262388AbVEMOKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:10:53 -0400
Message-ID: <4284B55C.7010202@pobox.com>
Date: Fri, 13 May 2005 10:10:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net>
In-Reply-To: <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Fri, May 13, 2005 at 07:51:20AM +0200, Gabor MICSKO wrote:
> 
>>Is this flaw affects the current stable Linux kernels? Workaround?
>>Patch?

Simple.  Just boot a uniprocessor kernel, and/or disable HT in BIOS.


> Some pages with relevant information:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0403.2/0920.html
> http://bugzilla.kernel.org/show_bug.cgi?id=2317

These pages have zero information on the "flaw."  In fact, I can see no 
information at all proving that there is even a problem here.

Classic "I found a problem, but I'm keeping the info a secret" security 
crapola.

	Jeff


