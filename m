Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVL3RR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVL3RR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVL3RR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:17:56 -0500
Received: from ns.firmix.at ([62.141.48.66]:60620 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964880AbVL3RRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:17:55 -0500
Subject: Re: userspace breakage
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43B549FB.1050503@wolfmountaingroup.com>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <43B453CA.9090005@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
	 <43B46078.1080805@wolfmountaingroup.com>
	 <1135941548.3342.22.camel@gimli.at.home>
	 <43B549FB.1050503@wolfmountaingroup.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Fri, 30 Dec 2005 18:17:04 +0100
Message-Id: <1135963024.3342.58.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 07:53 -0700, Jeff V. Merkey wrote:
> Bernd Petrovitsch wrote:
> >On Thu, 2005-12-29 at 15:17 -0700, Jeff V. Merkey wrote:
> >[...]
> >>Start caring. People spend lots of money supporting you, and what you 
> >>are doing. How about taking some
> >>responsibility for that so they don't change their minds and move back 
> >>to windows or pull their support because it's too
> >>costly or too much of a hassle to produce something stable from these 
> >>releases. If you export functions from the kernel,
> >
> >The "program a driver once, runs on every windows in the future" is
> >actually a myth. Talk to developers with windows drivers ....
> >It is just that the companies absolutely don't have a choice if MSFT
> >changes something ....
> >
> I support and write FS drivers for windows.   The same driver works on 
> 2002, 2002, 2003, and XP.  Longhorn have changed two IFS functions

Which are basically 2 stable versions (2000 & XP).
No 3.1, 95 and 98 support before?
Apart from that there are other drivers as FS drivers too.

> and that's it, and still loads the older fs drivers through a compat 
> interface.


	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



