Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVIAPUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVIAPUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVIAPUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:20:17 -0400
Received: from [85.8.12.41] ([85.8.12.41]:40857 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030198AbVIAPUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:20:15 -0400
Message-ID: <43171C02.30402@drzeus.cx>
Date: Thu, 01 Sep 2005 17:19:30 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: ncunningham@cyclades.com, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>	<1125557333.12996.76.camel@localhost>	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost> <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Hmm.  Looking at that bug report it specifies 2.6.11.  Does this
>problem really happen in 2.6.13?
>
>  
>

I first noticed it in 2.6.11. It was fixed sometime during 2.6.13-rc
only to be killed of again in 2.6.13-rc7. The bugzilla now has a patch
for 2.6.13 which fixes the problem again.

Rgds
Pierre

