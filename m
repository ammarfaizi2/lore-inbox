Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVKEWXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVKEWXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 17:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVKEWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 17:23:48 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:23692 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932212AbVKEWXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 17:23:47 -0500
Message-ID: <436D30F6.2050207@rtr.ca>
Date: Sat, 05 Nov 2005 17:23:50 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Edgar Hucek <hostmaster@ed-soft.at>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
References: <436C7E77.3080601@ed-soft.at> <20051105122958.7a2cd8c6.khali@linux-fr.org> <436CB162.5070100@ed-soft.at> <200511051347.54833.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511051347.54833.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
>
> ipw2200 "works" in 2.6.14, it's just the maintainer has opted to use a "stable 
> version" which lacks experimental features while ieee80211 gets up to scratch.

I haven't been able to get it working.  Nor does the external one seem
to work with 2.6.14 -- still stuck on 2.6.13 here, which impacts my ability
to help with testing of dev kernels.

-ml
