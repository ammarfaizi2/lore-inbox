Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVL0PsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVL0PsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVL0PsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:48:07 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:46259 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbVL0PsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:48:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kOluW6rFHfofgkTiJoueDBVmvh64z16FC1Dle8357NdQIyb8ZHmi4IRr6E6tOCwwflh+xFXDdg9t/RihGwt7sVuvPMC+89c9dy9yknAz2TNk3kWYY0CxDqsGjX1XLoJlAYmBtBGiXQLR792p+czqx8j5uYUYgrcIrgZAFiHZUbk=
Message-ID: <b6c5339f0512270748o477854fbrecc56784b5b340e7@mail.gmail.com>
Date: Tue, 27 Dec 2005 10:48:05 -0500
From: Bob Copeland <email@bobcopeland.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume support (try 2)
Cc: Lee Revell <rlrevell@joe-job.com>, jaco@kroon.co.za, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051226105056.0fc2ebaa.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43AF7724.8090302@kroon.co.za> <20051226082934.GD1844@elf.ucw.cz>
	 <43AFB005.50608@kroon.co.za> <1135609521.8293.33.camel@mindpipe>
	 <20051226105056.0fc2ebaa.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's been done afaik (at least in thunderbird bugzilla).
> The answer was something like "just use a plug-in (external) editor."
> I tried that, but it (tbird) still truncates trailing whitespace iirc.
> They seem to think that it's not a problem.  :(

Incidentally, while using mutt would be so much better, this is a
handy technique for those trapped behind a firewall with http proxy
who don't want to draw the ire of sysadmins by tunnelling.  Thought
I'd share since I did it expressly for sending patches:

1. Set up webmail.
2. Hack webmail to use wrap="off" on the textareas.
3. Use mosex or similar to have $YOUR_X11_EDITOR for editing textareas.
