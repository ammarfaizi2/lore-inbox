Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTENPpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTENPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:45:46 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:3336 "EHLO mail.intermeta.de")
	by vger.kernel.org with ESMTP id S261906AbTENPp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:45:28 -0400
Subject: Re: What exactly does "supports Linux" mean?
From: Henning Schmiedehausen <hps@intermeta.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030514144443.GA7203@suse.de>
References: <200305131114_MC3-1-38B0-3C13@compuserve.com>
	 <yw1x3cjifutq.fsf@zaphod.guide> <b9timt$e3m$3@tangens.hometree.net>
	 <20030514144443.GA7203@suse.de>
Content-Type: text/plain
Organization: INTERMETA - Gesellschaft  =?ISO-8859-1?Q?=20f=C3=BCr?= Mehrwertdienste mbH
Message-Id: <1052927883.18046.86.camel@forge.intermeta.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 17:58:03 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: -32.4 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_XIMIAN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a "2.5.xxx" number was a bad example. Consider it replaced by
"2.4.17" and "2.4.18". 



	Regards
		Henning


On Wed, 2003-05-14 at 16:44, Dave Jones wrote:
> On Wed, May 14, 2003 at 02:09:33PM +0000, Henning P. Schmiedehausen wrote:
> 
>  > >From a user land perspective, only major Linux vendors or
>  > organizations could enforce such a logo program, it would cost wads of
>  > cash and it will really suck if you currently run the certification
>  > process for Linux 2.5.102 for your driver and right before you're
>  > done, 2.5.103 is released and you have to start all over again.
> 
> Certifying anything against a development series kernel is completely
> pointless.  Breakage outside the driver itself could have adverse
> affects. Example: For the last dozen or so kernels, the i845 AGP driver
> crashed on exiting X. Turned out to be a VM bug.
> 
> 
> 		Dave
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

