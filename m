Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTFYU4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTFYU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:56:20 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:62946 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265087AbTFYU4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:56:17 -0400
Date: Wed, 25 Jun 2003 23:09:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul.Clements@steeleye.com, torvalds@transmeta.com,
       kernel list <linux-kernel@vger.kernel.org>
Cc: ldl@aros.net, steve@chygwyn.com
Subject: NBD maintainer change [was Re: Anyone for NBD maintainer]
Message-ID: <20030625210945.GD5164@elf.ucw.cz>
References: <20030625175849.GB4988@elf.ucw.cz> <Pine.LNX.4.10.10306251645580.11076-100000@clements.sc.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10306251645580.11076-100000@clements.sc.steeleye.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > BTW Anyone wanting to become nbd maintainer? I'm not much interested
> > in nbd these days...
> 
> I would like to take this on, if you don't want to do it anymore. I've
> been keeping up with the nbd source for quite a while now, so I think
> I'm ready to give it a shot.

Linus, I no longer have time/interest in maintaining NBD. Please
apply,

								Pavel

--- clean/MAINTAINERS	2003-06-24 12:27:38.000000000 +0200
+++ linux/MAINTAINERS	2003-06-25 23:03:26.000000000 +0200
@@ -1265,8 +1265,8 @@
 S:	Maintained
 
 NETWORK BLOCK DEVICE
-P:	Pavel Machek
-M:	pavel@atrey.karlin.mff.cuni.cz
+P:	Paul Clements
+M:	Paul.Clements@steeleye.com
 S:	Maintained
 
 NETWORK DEVICE DRIVERS


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
