Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTFLIHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 04:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTFLIHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 04:07:33 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:15881 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264741AbTFLIHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 04:07:25 -0400
Date: Thu, 12 Jun 2003 01:17:52 -0700
From: jw schultz <jw@pegasys.ws>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc8
Message-ID: <20030612081752.GE30794@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva> <20030610165622.A17342@google.com> <Pine.LNX.4.55L.0306102109340.30401@freak.distro.conectiva> <Pine.LNX.4.55L.0306111815100.31893@freak.distro.conectiva> <20030612.6274686@knigge.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612.6274686@knigge.local.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 06:27:46AM +0000, Michael Knigge wrote:
> imho the patch have to be included in 2.4.21 and (imho) it is a bad 
> practice to release a piece of software with a known bug (especially 
> if a fix is available).

A Linux kernel is not a "piece" of software.  It is a
compilation of software from many sources.  Marcelo juggles
the many tightly knit pieces of software and patches that
comprise the kernel.  At any time there are known bugs in
some part of it.  It takes a very careful hand to balance
frequency of releases vs stability of code vs bugs affecting
many or few.  Marcelo is doing quite well at something where
there will always be a few people disappointed.

Saying it is a bad idea to release a kernel with known bugs
is like saying it is a bad idea to buy a computer when the
price will be going down soon.  Would you care to delay
2.4.21 until next spring or would you rather get the fixes
it contains today and have 2.4.22 with your pet fix on
(hopefully) a scale of weeks?

Thank you, Marcelo.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
