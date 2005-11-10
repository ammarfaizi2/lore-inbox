Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVKJT3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVKJT3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKJT3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:29:52 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:49354 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751219AbVKJT3v (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:29:51 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: New Linux Development Model
Date: Thu, 10 Nov 2005 19:29:37 +0000
User-Agent: KMail/1.8.92
Cc: pomac@vapor.com, marado@isp.novis.pt, Linux-kernel@vger.kernel.org,
       fawadlateef@gmail.com, hostmaster@ed-soft.at, jerome.lacoste@gmail.com,
       carlsj@yahoo.com
References: <1131500868.2413.63.camel@localhost> <200511100055.58322.s0348365@sms.ed.ac.uk> <437362F3.4060401@rtr.ca>
In-Reply-To: <437362F3.4060401@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101929.37112.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 15:10, Mark Lord wrote:
[snip]
> Sure, us kernel folk can cope with all of that (in theory,
> though in practice I'm still stuck with 2.6.13 because I haven't
> yet gotten working ipw2200 with 2.6.14, with *either* driver).

I'm probably asking a silly question here, but presumably you've grabbed 
ieee80211 1.1.6 and ipw2200 1.0.8 from their respective websites, compiled 
them, installed them (whilst running 2.6.14) and the resulting driver does 
not work?

> But things just got WAY more complicated for most users of ipw2200.
> Sure, they can ignore us and just continue to run their old vendor
> kernels.  But this means they don't get up-to-date kernels with
> bug fixes and security fixes.  And more importantly to LKML,
> we've now just cut off a potentially large crowd of kernel-testers.
>
> Ugh.  Ugly.

I completely agree with this assessment, I was merely defending the "linux 
development process" which I do not believe to be at fault here.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
