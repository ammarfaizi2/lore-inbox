Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWFIUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWFIUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWFIUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:12:28 -0400
Received: from [80.71.248.82] ([80.71.248.82]:45245 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030482AbWFIUM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:12:26 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
	<20060609195750.GD10524@thunk.org> <4489D55F.20103@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Sat, 10 Jun 2006 00:14:21 +0400
In-Reply-To: <4489D55F.20103@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 16:09:03 -0400")
Message-ID: <m3k67q5boi.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> No, there is a key difference between ext3 and SCSI/etc.:  cruft is removed.

 JG> In ext3, old formats are supported for all eternity.

we'd need this anyway. just to let users to migrate.

thanks, Alex
