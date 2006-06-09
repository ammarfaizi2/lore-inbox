Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWFIQIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWFIQIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFIQIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:08:24 -0400
Received: from [80.71.248.82] ([80.71.248.82]:14757 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030250AbWFIQIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:08:23 -0400
X-Comment-To: Linus Torvalds
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 20:10:08 +0400
In-Reply-To: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> (Linus Torvalds's message of "Fri, 9 Jun 2006 08:40:14 -0700 (PDT)")
Message-ID: <m33beecntr.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Linus Torvalds (LT) writes:


 LT> Quite frankly, at this point, there's no way in hell I believe we can do 
 LT> major surgery on ext3. It's the main filesystem for a lot of users, and 
 LT> it's just not worth the instability worries unless it's something very 
 LT> obviously transparent.

I believe it's as stable as before until you mount with extents
mount option.

thanks, Alex
