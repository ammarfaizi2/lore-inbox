Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUDXUdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUDXUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUDXUdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:33:16 -0400
Received: from attila.bofh.it ([213.92.8.2]:40915 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S262361AbUDXUdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:33:12 -0400
Date: Sat, 24 Apr 2004 22:32:32 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: Greg KH <greg@kroah.com>
Cc: Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after boot)
Message-ID: <20040424203232.GB11476@wonderland.linux.it>
References: <408A1945.1030506@bigfoot.com> <20040424155507.GA11273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040424155507.GA11273@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, Greg KH <greg@kroah.com> wrote:

> On Sat, Apr 24, 2004 at 12:37:41AM -0700, Erik Steffl wrote:
> >   just moved to udev and everything seems to be working OK except of 
> > SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
> > works fine right after that).
> This is a Debian specific bug/issue.  I suggest you file it against the
> Debian udev package, as it is not a kernel issue.
What makes you think this is debian-specific? As you know, the debian
package does not have relevant patches.

I have not been able to reproduce this and I have no clue about how this
could be debugged, so I don't think that opening other duplicated bug
reports is going to help much...

-- 
ciao, |
Marco | [5950 alBoT3GxM9NbE]
