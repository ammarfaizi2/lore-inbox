Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTICTMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTICTGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:06:54 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:58349 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263938AbTICTGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:06:04 -0400
Subject: Re: devfs to be obsloted by udev?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Greg KH <greg@kroah.com>
Cc: Justin Cormack <justin@street-vision.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Sweetman <ed.sweetman@wmich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903184140.GA1651@kroah.com>
References: <3F54A4AC.1020709@wmich.edu>
	 <200309022219.02549.bzolnier@elka.pw.edu.pl>
	 <1062581929.30060.197.camel@lotte.street-vision.com>
	 <20030903184140.GA1651@kroah.com>
Content-Type: text/plain
Message-Id: <1062615962.30752.86.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Sep 2003 12:06:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 11:41, Greg KH wrote:

> What has been postponed to 2.7 is the moving of some of the boot code to
> use it some more.  But that's really just a matter of someone doing the
> work (and adding it to the build process properly.)  There are a few
> patches floating around somewhere that do this with the exception of
> intregrating into the build.

Actually, much of the work is both done and integrated into the build
already.

See http://klibc.bkbits.net/2.5-klibc for a kernel that has this stuff
in place.

	<b

