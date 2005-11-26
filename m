Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKZXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKZXsX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKZXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:48:23 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:35492 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750784AbVKZXsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:48:22 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Duncan Sands <duncan.sands@free.fr>
Subject: Re: speedtch driver, 2.6.14.2
Date: Sat, 26 Nov 2005 23:48:30 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200511241801.10424.duncan.sands@free.fr>
In-Reply-To: <200511241801.10424.duncan.sands@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511262348.30493.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 17:01, Duncan Sands wrote:
> > I recently switched from the userspace speedtouch driver to the in-kernel
> > one. However, on my rev 4.0 Speedtouch 330, I periodically get the
> > message:
> >
> > ATM dev 0: error -110 fetching device status
>
> By the way, did you use to monitor the line using modem_run?  Did it work
> (and of course: did you get any error messages?).

I don't use modem_run any more, but when I did (with the userspace driver), I 
would not get any errors whatsoever. It didn't reconnect automatically, 
however.

I'll try enabling USB_DEBUG next time I upgrade that machine's kernel. 
Unfortunately I don't have access to it at the moment (but will within the 
week).

Thanks for the help so far!

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
