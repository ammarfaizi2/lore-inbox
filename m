Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTICTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTICTTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:19:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:12548 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264316AbTICTRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:17:13 -0400
Date: Wed, 3 Sep 2003 21:17:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: Justin Cormack <justin@street-vision.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Sweetman <ed.sweetman@wmich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs to be obsloted by udev?
Message-ID: <20030903191701.GA12532@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Justin Cormack <justin@street-vision.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F54A4AC.1020709@wmich.edu> <200309022219.02549.bzolnier@elka.pw.edu.pl> <1062581929.30060.197.camel@lotte.street-vision.com> <20030903184140.GA1651@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903184140.GA1651@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 11:41:40AM -0700, Greg KH wrote:
> What has been postponed to 2.7 is the moving of some of the boot code to
> use it some more.  But that's really just a matter of someone doing the
> work (and adding it to the build process properly.)  There are a few
> patches floating around somewhere that do this with the exception of
> intregrating into the build.

Can some one sched a bit more light on what is seeked to get it integrated
in the build. Kai G. did a big update in this area some time ago -
but maybe more is needed?

I could give the build issue a spin.

	Sam
