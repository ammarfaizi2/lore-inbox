Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVKOSx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVKOSx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVKOSx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:53:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:19925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964974AbVKOSx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:53:28 -0500
Date: Tue, 15 Nov 2005 19:53:26 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
       Michael Buesch <mbuesch@freenet.de>,
       ppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051115185326.GA13782@suse.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de> <1131834336.7406.46.camel@gaston> <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org> <1131915560.5504.67.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1131915560.5504.67.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Nov 14, Benjamin Herrenschmidt wrote:

> On Sun, 2005-11-13 at 10:37 -0600, Kumar Gala wrote:
> 
> > Can we please add some defconfigs for arch/powerpc to possibly help  
> > with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
> > bit configs would be a good start.
> 
> The 64 bits defconfigs are there already. I'll do a pmac one.

Can you move also arch/ppc64/defconfig into arch/powerpc/configs/?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
