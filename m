Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUJVTpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUJVTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJVTpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:45:22 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:33124 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S266386AbUJVToF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:44:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9.3
To: tglx@linutronix.de
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF86131D2C.7F017684-ON86256F35.006C000C@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Fri, 22 Oct 2004 14:40:39 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/22/2004 02:40:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, the fix was for the missing pci shutdown in tulip.
I thought the two were related (since I get the failed to shutdown
message right after that traceback. Perhaps the 8139too needs
that same shutdown fix.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

