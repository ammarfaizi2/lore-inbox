Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSKYMTs>; Mon, 25 Nov 2002 07:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbSKYMTs>; Mon, 25 Nov 2002 07:19:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:14017 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262959AbSKYMTr>;
	Mon, 25 Nov 2002 07:19:47 -0500
Date: Mon, 25 Nov 2002 12:23:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: torvalds@transmeta.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com, rob@osinvestor.com
Subject: Re: [PATCH] linux-2.5.49 - Watchdog drivers
Message-ID: <20021125122342.GB22915@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com,
	rob@osinvestor.com
References: <20021124003103.A8544@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124003103.A8544@medelec.uia.ac.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 12:31:03AM +0100, Wim Van Sebroeck wrote:
 > Hi Linus, Dave,
 > 
 > included the patch for linux-2.5.49 to make the watchdog drivers working again.
 > Could you apply this to the current tree please?
 > 
 > PS: the patch is also ftp-able at: ftp://medelec.uia.ac.be/pub/linux/kernel-patches/wd-2.5.49-patch

Yup. I screwed up a few things (and actually pushed the wrong tree
into the 'pull' tree for Linus *sigh*)
I'll set about putting things right this afternoon.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
