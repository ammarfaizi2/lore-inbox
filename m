Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTGXMHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTGXMHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:07:10 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:39578 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263319AbTGXMHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:07:09 -0400
Date: Thu, 24 Jul 2003 08:20:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: time for some drivers to be removed?
Message-ID: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i've mentioned this before, but in a perfect world, should it
be possible to build a release version of the kernel with
"make allyesconfig".  this is generally not possible, since there's
always the occasional broken driver that just won't compile.

  more to the point, there are drivers that seem to be perpetually
broken.  as an example, the riscom8 driver has been borked for as 
long as i can remember.  at some point, shouldn't something like
this either be fixed or just removed?  what's the point of 
perpetually bundling a driver that doesn't even compile?

rday
