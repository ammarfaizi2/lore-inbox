Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSKFQ22>; Wed, 6 Nov 2002 11:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265789AbSKFQ22>; Wed, 6 Nov 2002 11:28:28 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:26854 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265786AbSKFQ20> convert rfc822-to-8bit; Wed, 6 Nov 2002 11:28:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: NUMA scheduler BK tree
Date: Wed, 6 Nov 2002 17:34:42 +0100
User-Agent: KMail/1.4.1
Cc: Robert Love <rml@tech9.net>, Anton Blanchard <anton@samba.org>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211061734.42713.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, Martin,

in order to make it easier to keep up with the main Linux tree I've
set up a bitkeeper repository with our NUMA scheduler at
       bk://numa-ef.bkbits.net/numa-sched
(Web view:  http://numa-ef.bkbits.net/)
This used to contain my node affine NUMA scheduler, I'll add extra
trees when the additional patches for that are tested on top of our
NUMA scheduler.

Is it ok for you to have it this way or would you prefer having the
core and the initial load balancer separate?

The tree is currently in sync with bk://linux.bkbits.net/linux-2.5 and
I'll try to keep so.

Regards,
Erich

