Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFJVTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFJVTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFJVTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:19:03 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:18573
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261241AbVFJVS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:18:58 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: "'kernel list'" <linux-kernel@vger.kernel.org>
Subject: RE: ipw2100: firmware problem
Date: Fri, 10 Jun 2005 15:18:54 -0600
Message-ID: <003201c56e02$025d0e10$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1118437639.6423.65.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Riiiight. It could be. Or it could be that no where in the 
> world I have seen
> > something where the device would be disabled by default 
> without notifying
> > the user. Why would you Mute the driver? Is the driver that 
> bad, that the
> > developers would rather Mute the sound card, just in case 
> if the sound cards
> > starts making noises and shit when the driver is loaded?
> > 
> 
> Userspace should handle it, doing this in the kernel is bloat.

I Agreed to this since 8 AM.

> 
> My Debian system initializes the mixer settings to a sane state just
> fine when the alsasound init script is run.  Maybe you need a better
> distro.
I use Debian.
> 
> Users who compile ALSA from source are expected to know what they are
> doing.  And, if you watch the "make install" output, it 
> prints a big fat
> warning that all mixer controls are muted by default.

Who said I did it from source?

> 
> > You are moving to another topic. Let's drop it.
> 
> Agreed, but it was your OT rant that changed the topic...
> 
> Lee
dropped.
.Alejandro 
