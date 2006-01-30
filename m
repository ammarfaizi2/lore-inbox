Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWA3NWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWA3NWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWA3NWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:22:33 -0500
Received: from [212.76.87.221] ([212.76.87.221]:12548 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932254AbWA3NW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:22:27 -0500
From: Al Boldi <a1426z@gawab.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Mon, 30 Jan 2006 16:21:24 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
In-Reply-To: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601301621.24051.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
> >> So we know it [single level storage] works, but also that people don't
> >> seem to care much for it
>
> > People didn't care, because the AS/400 was based on a proprietary
> > solution.
>
> I don't know what a "proprietary solution" is, but what we had was a
> complete demonstration of the value of single level storage, in commercial
> use and everything,  and other computer makers (and other business units
> of IBM) stuck with their memory/disk split personality.  For 25 years,
> lots of computer makers developed lots of new computer architectures and
> they all (practically speaking) had the memory/disk split.  There has to
> be a lesson in that.

Sure there is lesson here.  People have a tendency to resist change, even 
though they know the current way is faulty.

> > With todays generically mass-produced 64bit archs, what's not to care
> > about a cost-effective system that provides direct mapped access into 
> > linear address space?
>
> I don't know; I'm sure it's complicated.

Why would you think that the shortest path between two points is complicated, 
when you have the ability to fly?

> But unless the stumbling block
> since 1980 has been that it was too hard to get/make a CPU with a 64 bit
> address space, I don't see what's different today.

You are hitting the nail right on it's head here.
Nothing moves the masses like mass-production.

So with 64bits widely available now, and to let Linux spread its wings and 
really fly, how could tmpfs merged w/ swap be tweaked to provide direct 
mapped access into this linear address space?

Thanks!

--
Al

