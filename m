Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbTGXT3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbTGXT3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:29:38 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:56306 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269473AbTGXT3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:29:36 -0400
Date: Thu, 24 Jul 2003 15:43:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
cc: ml@basmevissen.nl, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
In-Reply-To: <20030724211611.3f969ae4.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.53.0307241541200.21531@localhost.localdomain>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
 <1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk> <3F1FFC94.7080409@basmevissen.nl>
 <20030724193211.39d7ed68.diegocg@teleline.es>
 <Pine.LNX.4.53.0307241346490.20950@localhost.localdomain>
 <20030724211611.3f969ae4.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, Diego Calleja [ISO-8859-15] García wrote:

> El Thu, 24 Jul 2003 13:50:48 -0400 (EDT) "Robert P. J. Day" <rpjday@mindspring.com> escribió:
> 
> > and in the end, while i know some folks don't think it's a big
> > deal, i think doing a "make allyesconfig" really should work.
> 
> well, AFAIK "make allyesconfig" is a debug target; ie. it 
> shouldn't be succesful from a developer point of view.

you're right, that's a good point.  but using the example
i used before, it should still not be acceptable to allow
someone to select the "riscom8" driver explicitly and have 
it fail to compile.

your point about the debug target is well taken, though.

ok, i'm going back to work now.  really.

rday
