Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTGXTBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbTGXTBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:01:12 -0400
Received: from smtp.terra.es ([213.4.129.129]:6303 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S269981AbTGXTBK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:01:10 -0400
Date: Thu, 24 Jul 2003 21:16:11 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: ml@basmevissen.nl, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Message-Id: <20030724211611.3f969ae4.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.53.0307241346490.20950@localhost.localdomain>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	<1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>
	<3F1FFC94.7080409@basmevissen.nl>
	<20030724193211.39d7ed68.diegocg@teleline.es>
	<Pine.LNX.4.53.0307241346490.20950@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 24 Jul 2003 13:50:48 -0400 (EDT) "Robert P. J. Day" <rpjday@mindspring.com> escribió:

> and in the end, while i know some folks don't think it's a big
> deal, i think doing a "make allyesconfig" really should work.

well, AFAIK "make allyesconfig" is a debug target; ie. it 
shouldn't be succesful from a developer point of view.

I guess what you meant is if we want to say to final users
"the driver for your hardware doesn't compile" or "your hardware isn't
supported (unless you're a developer who wants to fix it)" in which case
i'd say "yes"

Or instead, "should make allyesconfig compile drivers marked as obsolete",
where i'd also say "yes"

But sadly i can't fix all those drivers so i'll stop whining and let the real
developers do whatever they want ;)
