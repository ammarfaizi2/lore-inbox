Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbSI0RBa>; Fri, 27 Sep 2002 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbSI0RBa>; Fri, 27 Sep 2002 13:01:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62663 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262153AbSI0RB3>; Fri, 27 Sep 2002 13:01:29 -0400
Date: Fri, 27 Sep 2002 10:07:41 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Vasquez <praka@san.rr.com>,
       Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patmans@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020927170740.GC1366@beaverton.ibm.com>
Mail-Followup-To: Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Vasquez <praka@san.rr.com>,
	Michael Clark <michael@metaparadigm.com>,
	"David S. Miller" <davem@redhat.com>, wli@holomorphy.com,
	axboe@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org,
	patmans@us.ibm.com
References: <B179AE41C1147041AA1121F44614F0B004F771@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B179AE41C1147041AA1121F44614F0B004F771@AVEXCH02.qlogic.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Vasquez [andrew.vasquez@qlogic.com] wrote:
> In my mind, a larger question is determining a balance between the 
> 'Release Early, release often' mantra of Linux development and the 
> 'kinder, more conservative pace' of business.  For example, If we 
> cannot setup a 'patch/pre-beta' web-site locally at QLogic, I've 
> considered starting a SourceForge project or hosting it locally 
> through my ISP. 

Currently the release method of not having patches against older
releases of the driver or even an archive of the full older release has
resulted in having others duplicate this functionality.

It would be great if you could set up a patch site.


-andmike
--
Michael Anderson
andmike@us.ibm.com

