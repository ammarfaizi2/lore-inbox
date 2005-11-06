Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVKFA2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVKFA2q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKFA2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:28:46 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:44774 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932239AbVKFA2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:28:46 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: New Linux Development Model
Date: Sun, 6 Nov 2005 00:28:29 +0000
User-Agent: KMail/1.8.92
Cc: Edgar Hucek <hostmaster@ed-soft.at>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <436C7E77.3080601@ed-soft.at> <200511051347.54833.s0348365@sms.ed.ac.uk> <436D30F6.2050207@rtr.ca>
In-Reply-To: <436D30F6.2050207@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511060028.30018.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 22:23, Mark Lord wrote:
> Alistair John Strachan wrote:
> > ipw2200 "works" in 2.6.14, it's just the maintainer has opted to use a
> > "stable version" which lacks experimental features while ieee80211 gets
> > up to scratch.
>
> I haven't been able to get it working.  Nor does the external one seem
> to work with 2.6.14 -- still stuck on 2.6.13 here, which impacts my ability
> to help with testing of dev kernels.

Well, the in-kernel 1.0.0 works fine here on 2.6.14 (no WPA of course). The 
only caveat is that you need to downgrade your firmware if you've been using 
1.0.7 (or 1.0.8) prior, which I had and was initially confusing.

Otherwise, I suggest you file a bug report.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
