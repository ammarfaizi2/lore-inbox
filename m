Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUAMVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUAMVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:01:27 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:57729 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265647AbUAMVAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:00:53 -0500
Date: Tue, 13 Jan 2004 22:00:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: George Anzinger <george@mvista.com>
Cc: Matt Mackall <mpm@selenic.com>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb cleanups
Message-ID: <20040113210035.GA474@elf.ucw.cz>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org> <400233A5.8080505@mvista.com> <20040112064923.GX18208@waste.org> <20040112094543.GA10869@elf.ucw.cz> <40045AF6.5000905@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40045AF6.5000905@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>For the internal kgdb stuff I have created kdgb_local.h which I intended 
> >>>to be local to the workings of kgdb and not to contain anything a user 
> >>>would need.
> >>
> >>Agreed, I just haven't touched it since you last mentioned it.
> >
> >
> >I believe we need better name than kgdb_local.h.... Hmm, but I'm not
> >sure what the name should be.
> 
> Sure.  How about kgdb_internal.h  ??

Yes, that looks better. [Somehow I thought even better name has to
exists.]
 
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
