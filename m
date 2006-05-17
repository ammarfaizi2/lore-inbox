Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWEQPGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEQPGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWEQPGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:06:35 -0400
Received: from mxsf10.cluster1.charter.net ([209.225.28.210]:11979 "EHLO
	mxsf10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750958AbWEQPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:06:34 -0400
X-IronPort-AV: i="4.05,138,1146456000"; 
   d="scan'208"; a="258513008:sNHT66378226"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17515.15349.651895.412025@smtp.charter.net>
Date: Wed, 17 May 2006 11:06:29 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: libata PATA updated patch
In-Reply-To: <1147867347.10470.6.camel@localhost.localdomain>
References: <1147796037.2151.83.camel@localhost.localdomain>
	<17514.11859.976557.532929@smtp.charter.net>
	<1147867347.10470.6.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Should I bother testing this on my HPT302 box?  I didn't see any
>> response to my earlier bug reports, just checking to make sure I'm
>> doing a usefull service here.

Alan> I've not attacked the HPT3xx hardware again yet. For one the
Alan> fact that Sergei Shtylyov is rewriting the "old style" driver
Alan> for it to knock a lot of the problems out means much of that
Alan> stuff will want porting again once he is finished

Thanks, I'll hold off for now then, but I'm more than happy to run
tests for you in you need them.  

Alan> Sergei may well appreciate testers however.

Alan> Thanks for the testing so far

You're very welcome!  Least I can do, not being a kernel programmer.
