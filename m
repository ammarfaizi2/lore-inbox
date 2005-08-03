Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVHCGGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVHCGGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVHCGGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:06:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25806 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262067AbVHCGGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:06:50 -0400
Date: Wed, 3 Aug 2005 08:06:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Andrew Burgess <aab@cichlid.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: BTTV - experimental no_overlay patch
Message-ID: <20050803060640.GC1399@elf.ucw.cz>
References: <1123040424.5607.46.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123040424.5607.46.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	This small patch will allow no_overlay flag to disable BTTV driver to
> report OVERLAY capabilities. It should fix your troubles by enabling
> no_overlay=1 when inserting bttv module.
> 
> 	This patch is against our CVS tree, but should apply with some hunk on
> 2.6.13-rc4 or 2.6.13-rc5.
> 
> 	I'll generate a new one at morning, against 2.6.13-rc5 hopefully to
> have it applied at 2.6.13, since it fixes an OOPS.

You have to pass option for it not to oops? That does not seem
right....

								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
