Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSFXPKO>; Mon, 24 Jun 2002 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSFXPKN>; Mon, 24 Jun 2002 11:10:13 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:14209 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S314083AbSFXPKM>;
	Mon, 24 Jun 2002 11:10:12 -0400
Date: Sat, 22 Jun 2002 20:27:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020622182712.GC105@elf.ucw.cz>
References: <20020620105233.A5506@eng2.beaverton.ibm.com> <Pine.LNX.4.44.0206201133180.8225-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201133180.8225-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I personally think that the biggest problem with driverfs is it's lack of
> a 2.4.x counterpart. Although the filesystem itself should be fairly
> easy

Well, the thing just does not exist in 2.4.X. I can't see how this can
be helped. [It would be usefull. This way it is close to impossible to
make S3 work nicely in 2.4.X.]
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
