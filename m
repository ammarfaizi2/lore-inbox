Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUBPNom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUBPNom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:44:42 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:45268 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265530AbUBPNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:44:41 -0500
Date: Mon, 16 Feb 2004 08:32:47 -0500
From: Ben Collins <bcollins@debian.org>
To: Roland Mas <roland.mas@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.25-rc1 -- video1394
Message-ID: <20040216133247.GB4691@phunnypharm.org>
References: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org> <20040209175731.GN1042@phunnypharm.org> <873c9j3nm4.fsf@mirexpress.internal.placard.fr.eu.org> <87hdxrnxcr.fsf@mirexpress.internal.placard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdxrnxcr.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I still think the kernel shouldn't oops, but if I can find a
> userspace fix, I won't mind that much :-)

Yeah, the kernel definitely shoudln't oops, even if kino doesn't
something wrong. It's probably doing something wrong, and the video1394
driver just isn't doing the proper checks.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
