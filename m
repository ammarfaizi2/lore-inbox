Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbUB0Mb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUB0Mb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:31:28 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:25305 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262614AbUB0M3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:29:52 -0500
Date: Fri, 27 Feb 2004 07:28:43 -0500
From: Ben Collins <bcollins@debian.org>
To: Daniel Robbins <drobbins@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 sbp2 broken since 2.6.0-test11
Message-ID: <20040227122843.GC4019@phunnypharm.org>
References: <1077867528.12590.79.camel@wave.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077867528.12590.79.camel@wave.gentoo.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 12:38:48AM -0700, Daniel Robbins wrote:
> Ben,
> 
> I've been having to use the ieee1394 driver from 2.6.0-test10 in order
> to burn CDs reliably. With 2.6.0-test11 and beyond, I experience
> intermittent login failures and then reconnect failures to my firewire
> CD burners. With 2.6.3, even when the login or reconnect goes OK, the
> system can hard-lock while burning. The CD burners are using Oxford 911
> chips, firmware 3.6 and 3.8. I've tested using a variety of firewire PCI
> cards and mainboards, both SMP (uniprocessor hyper-threading) and UP,
> and a couple of different CD drives.

Have you tried the latest 2.6 bk? I did a lot of work with sbp2 and the
nodemgr.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
