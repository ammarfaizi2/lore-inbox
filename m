Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWBGDRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWBGDRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBGDRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:17:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50588 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932445AbWBGDRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:17:07 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060207030129.GA23860@mail>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <1139251682.2791.290.camel@mindpipe>
	 <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl>
	 <20060207003713.GB31153@voodoo> <20060207004611.GD1575@elf.ucw.cz>
	 <20060207005930.GD31153@voodoo> <1139275143.2041.24.camel@mindpipe>
	 <20060207030129.GA23860@mail>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 22:17:04 -0500
Message-Id: <1139282224.2041.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> With uswsusp it'll be more flexible in that you'll be able to use any
> userland process or library to transform the image before storing it, but
> the suspend and resume processes are going to be a lot more complicated.
> For instance, how are you going to tell the kernel that you need the
> uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the rest of
> userland has been frozen?

Unless someone at least gives a rough estimate of 1) what % of users
can't suspend their laptops now and 2) of these, what % are helped by
suspend2, this thread is just handwaving...

Lee 

