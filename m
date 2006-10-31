Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423800AbWJaTFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423800AbWJaTFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423801AbWJaTFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:05:38 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:36102 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1423800AbWJaTFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:05:37 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 19:05:33 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, John Richard Moser <nigelenki@comcast.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20061031174006.GA31555@dreamland.darkstar.lan>
In-Reply-To: <20061031174006.GA31555@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311905.33667.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> > On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> > [snip]
> >
> >> However, we already have code that allows us to use swap files for the
> >> suspend and turning a regular file into a swap file is as easy as
> >> running 'mkswap' and 'swapon' on it.
> >
> > How is this feature enabled? I don't see it in 2.6.19-rc4.
>
> Swap files have been supported for ages. suspend-to-swapfile is very
> new, you need a -mm kernel and userspace suspend from CVS:
> http://suspend.sf.net

I know, I use swap files, and not a partition. This has prevented me from 
using suspend to disk "for ages". ;-)

Is userspace suspend REQUIRED for this feature?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
