Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTFLJ00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFLJ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:26:25 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:25099
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S264534AbTFLJYu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:24:50 -0400
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055406614.2551.6.camel@tor.trudheim.com>
References: <1055371846.4071.52.camel@localhost.localdomain>
	 <1055406614.2551.6.camel@tor.trudheim.com>
Content-Type: text/plain
Message-Id: <1055410711.10219.44.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 02:38:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 01:30, Anders Karlsson wrote:
> If the patch could be applied against 2.4.21-rc, I'd be testing it out.
> Anything that can make the 'stable' kernel perhaps a bit more stable on
> the X31 Thinkpad is IMHO a Good Thing.

It shouldn't have any effect on stability.  It only adds a new feature:
CPU speed control.

I've found 2.5 to be very stable on my X31.  Except for wireless.

	J

