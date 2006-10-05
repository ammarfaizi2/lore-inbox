Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWJEVBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJEVBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWJEVBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:01:30 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:41869 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751299AbWJEVB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:01:29 -0400
From: Dominique Dumont <domi.dumont@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	<87y7rusddc.fsf@gandalf.hd.free.fr>
	<1160081110.2481.104.camel@mindpipe>
Date: Thu, 05 Oct 2006 23:01:28 +0200
In-Reply-To: <1160081110.2481.104.camel@mindpipe> (Lee Revell's message of
	"Thu, 05 Oct 2006 16:45:10 -0400")
Message-ID: <87r6xmscif.fsf@gandalf.hd.free.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: domi.dumont@free.fr
X-SA-Exim-Scanned: No (on gandalf.hd.free.fr); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> This is going to be a problem with the SATA driver not ALSA.  I've heard
> that some motherboards do evil stuff like implementing legacy drive
> access modes using SMM which would cause dropouts without xruns
> reported.

Why do I hear distortion with PCM on SPDIF output and no distortion at
all on analog front output ? (both with the SB Live card)

> Please report it on LKML.

Will do. (although your mail and this mail are cc'ed to LKLM)

Thanks
