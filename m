Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTEVQk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTEVQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:40:58 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:28164 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262811AbTEVQku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:40:50 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "David Lewis" <dlewis@vnxsolutions.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] kswapd 2.4.20
Date: Thu, 22 May 2003 18:51:29 +0200
User-Agent: KMail/1.5.1
Cc: "Erin Britz" <ebritz@vnxsolutions.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
References: <EMEOIBCHEHCPNABJGHGOOEKPCNAA.dlewis@vnxsolutions.com>
In-Reply-To: <EMEOIBCHEHCPNABJGHGOOEKPCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305221829.49270.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 May 2003 18:01, David Lewis wrote:

Hi David,

> Thanks for the pointers to the new VM systems. I changed the kernel over to
np.

> 2.4.21-rc2-ac2 (has rmap in it, right?) and I am rerunning my tests to see
> if that solves the problem.
Nope, -ac dropped rmap some weeks ago (or even months). Carldani is right :)

> I agree with Andrea about bugs.. I certainly accept them as a necessary
> evil. I tend to get frustrated when faced with something that I dont have
> the skill to solve myself however. Especially so when I cant seem to get
> pointed in the right direction by anyone. :)
hehe :) ... Well, some people including me are frustrated about sending 
patches (bugfixes) again and again to only see silent ignores, thus also 
frustrated about telling the issues, pointing to fixes etc.

> Thanks again for your suggestion, and I will let you know if it works out!
thanks :) Would be great to hear from you if it'll work (I'll bet it will ;)

ciao, Marc


