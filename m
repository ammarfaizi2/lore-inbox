Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUIIW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUIIW56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUIIW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:57:58 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:4037 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S266705AbUIIW55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:57:57 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Free Ekanayaka <free@agnula.org>,
       free78@tin.it, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFCD36C23F.77F7902E-ON86256F0A.007DDE1A@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Sep 2004 17:56:51 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/09/2004 05:56:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I tried
>  hdparm -p -X udma2 /dev/hda
>(since it was udma4 previously)
>and reran the tests.
Not quite sure this was what I wanted - appears to turn on PIO modes
exclusively.

What is the right incantation for this?
Thanks.
--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

