Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289862AbSBEXVn>; Tue, 5 Feb 2002 18:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289865AbSBEXVj>; Tue, 5 Feb 2002 18:21:39 -0500
Received: from [207.155.248.78] ([207.155.248.78]:12232 "EHLO glatton.xo.com")
	by vger.kernel.org with ESMTP id <S289862AbSBEXVG>;
	Tue, 5 Feb 2002 18:21:06 -0500
From: "Dave Francheski" <davef@seven-systems.com>
To: <linux-kernel@vger.kernel.org>
Cc: <davef@seven-systems.com>
Subject: gprof / profiling support ?
Date: Tue, 5 Feb 2002 15:20:47 -0800
Message-ID: <LBEMJABKBLOPOMBFFMDEKECOCBAA.davef@seven-systems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3C5C1E8A.9D0FFAD3@torque.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to profile an application
using the 'gprof' utility, and in particular
get timing information from the profile.

For some reason, the output from gprof
displays 

"no time accumulated"

and I see no cumulative/self seconds
at all.  However, all of the call counts
appear to be correct.

I suspect that the sampling rate using
by gprof/linux is simply two slow, given
the particular application I'm running.

Can anybody help me obtain timing information
from gprof and/or point me to a better
source for application profiling in general?

Thankyou for your support.
David Francheski

