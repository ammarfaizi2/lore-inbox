Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVBPKIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVBPKIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 05:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVBPKIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 05:08:13 -0500
Received: from viking.sophos.com ([194.203.134.132]:47627 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261985AbVBPKIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 05:08:06 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: adaplas@pol.net, benh@kernel.crashing.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Radeon FB troubles with recent kernels
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF22755359.1A0F5F7D-ON80256FAA.00377C11-80256FAA.0037ABDE@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 16 Feb 2005 10:08:02 +0000
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 16/02/2005 10:08:04,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 16/02/2005 10:08:04,
	Serialize complete at 16/02/2005 10:08:04,
	S/MIME Sign failed at 16/02/2005 10:08:04: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 16/02/2005 10:08:05,
	Serialize complete at 16/02/2005 10:08:05
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2005 20:39:02 linux-kernel-owner wrote:

>On my Thinkpad T30 with a Radeon Mobility M7 LW, I get interesting
>console video corruption if I start GDM, switch back to text mode,
>then stop it again. X is Xfree86 from Debian/unstable or X.org 6.8.2.
>
>The corruption shows up whenever the console scrolls after X has been
>shut down and manifests as horizontal lines spaced about 4 pixel rows
>apart containing contents recognizable as the X display. Switch from
>vt1 to vt2 and back or visual bell clears things back to normal, but
>corruption will reappear on the next scroll.
>
>This has appeared in at least 2.6.11-rc3-mm2 and rc4.

Same problem here (same chip) for a long long time (at least 2.6.6) so I 
don't think it appeared with latest changes.


-- 
Tvrtko August Ursulin
Software Engineer, Sophos

Tel: 01235 559933
Web: www.sophos.com
Sophos - protecting businesses against viruses and spam

