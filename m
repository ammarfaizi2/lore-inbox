Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUHTICw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUHTICw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTICv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:02:51 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:26742 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264261AbUHTICo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:02:44 -0400
Message-ID: <d577e56904082001023b2faad9@mail.gmail.com>
Date: Fri, 20 Aug 2004 04:02:40 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4124BA65.7010509@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200408041233.i74CX93f009939@wildsau.enemy.org>	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner> <1092919260.28141.30.camel@localhost.localdomain> <4124BA65.7010509@bio.ifi.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 16:34:13 +0200, Frank Steiner
<fsteiner-mail@bio.ifi.lmu.de> wrote:
> Here's what I see when I call cdrecord on SuSE 9.1:
> 
> Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright (C) 1995-2004 Jörg Schilling
> Note: This version is an unofficial (modified) version with DVD support
> Note: and therefore may have bugs that are not present in the original.
> Note: Please send bug reports or support requests to http://www.suse.de/feedback
> Note: The author of cdrecord should not be bothered with problems in this version.

And debian does:

Cdrecord-Clone 2.01a34 (i686-pc-linux-gnu) Copyright (C) 1995-2004
Jorg Schilling
Note: This version of cdrecord is an inofficial (modified) release of cdrecord
and thus may have bugs that are not present in the original version.
Please send bug reports and support requests to <cdrtools@packages.debian.org>.
The original author should not be bothered with problems of this version




-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
