Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUDIWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUDIWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:49:27 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:12233 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261832AbUDIWt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:49:26 -0400
Message-Id: <200404092249.i39MnNwx025652@dhin.linuxaudiosystems.com>
To: "Ivica Ico Bukvic" <ico@fuse.net>
cc: "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>
Subject: Re: [Alsa-devel] RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news! 
In-reply-to: Your message of "Fri, 09 Apr 2004 18:25:47 EDT."
             <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass> 
Date: Fri, 09 Apr 2004 18:49:23 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.151.78.146] at Fri, 9 Apr 2004 17:49:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, if there is a way of monitoring these hex registers for various
>hardware in Linux I could try to compare their state upon initialization in
>Linux to that one in Windows (since in both situations they share the same
>IRQ, at least on my notebook) and forward this info to you guys.
>
>So my question at this point is, is there such hex-editor in Linux that
>allows this kind of monitoring and if so where can I obtain it?

i would imagine that you have it already, though its cmdline: setpci
(and lspci -vv for the display side, so to speak).

not sure if this is really the equivalent, but i suspect that it is.

--p


