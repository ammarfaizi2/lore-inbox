Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGQUlE>; Wed, 17 Jul 2002 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSGQUlD>; Wed, 17 Jul 2002 16:41:03 -0400
Received: from ns.suse.de ([213.95.15.193]:25093 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316705AbSGQUlA>;
	Wed, 17 Jul 2002 16:41:00 -0400
Date: Wed, 17 Jul 2002 22:43:55 +0200
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] agpgart changes for 2.5.26
Message-ID: <20020717224355.B9489@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020717183615.GB9589@kroah.com> <20020717213056.I18170@suse.de> <20020717203601.GB10047@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717203601.GB10047@kroah.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 01:36:01PM -0700, Greg KH wrote:
 > But that would make:
 > 	drivers/char/agp/via-agp.c
 > which is redundant, as that file does not compile to a separate module,
 > but gets linked to the larger agpgart.o like before.

That's exactly what I said 8-)
But... http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-28/0125.html

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
