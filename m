Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSLTSgj>; Fri, 20 Dec 2002 13:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSLTSgj>; Fri, 20 Dec 2002 13:36:39 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61091 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264755AbSLTSgi>;
	Fri, 20 Dec 2002 13:36:38 -0500
Date: Fri, 20 Dec 2002 18:44:01 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Next round of AGPGART fixes.
Message-ID: <20021220184401.GA2496@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Felix Seeger <felix.seeger@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de> <200212201542.48221.felix.seeger@gmx.de> <200212201741.05692.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212201741.05692.felix.seeger@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 05:41:05PM +0100, Felix Seeger wrote:
 > > I am running 2.5.52bk5 with you GNU patch. Doesn't help.
 > > I do a modprobe i810 and I get:
 > >
 > > FATAL: Error inserting i810
 > > (/lib/modules/2.5.52bk5/kernel/drivers/char/drm/i810.ko): Cannot allocate
 > > memory
 > >
 > Mhm, I compiled all in the kernel and it works now, maybe I've done something 
 > wrong.

More likely there are more modules related thinkos in the code.
I'll look it over again later.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
