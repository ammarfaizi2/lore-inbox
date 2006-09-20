Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWITOgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWITOgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWITOgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:36:51 -0400
Received: from mail.timesys.com ([65.117.135.102]:62163 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1751569AbWITOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:36:50 -0400
Subject: 2.6.18-hrt-dyntick1
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 16:37:48 +0200
Message-Id: <1158763068.5724.999.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce the availability of the 2.6.18-hrt-dyntick1
patchset. It's available from the usual place:

http://tglx.de/projects/hrtimers/2.6.18/patch-2.6.18-hrt-dyntick1.patch

The broken out patch series can be found here:

http://tglx.de/projects/hrtimers/2.6.18/patch-2.6.18-hrt-dyntick1.patches.tar.bz2

The patchset contains following updates:

- Generic timeofday improvements (John Stultz)
- NTP improvements (Roman Zippel)

- x86_64 support (Arjan van de Ven)
- initial ARM/PPC bits (Kevin Hilman, Deepak Saksena, Sergei Shtylyov)

- New timer statistics implementation, which covers also hrtimers

- Updates and bugfixes all over the place.

As usual, bugreports, fixes and suggestions are welcome,

	tglx


