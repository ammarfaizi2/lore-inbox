Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUGHM4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUGHM4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGHM4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:56:50 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:30276 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262837AbUGHM4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:56:49 -0400
X-Ironport-AV: i="3.81R,157,1083560400"; 
   d="scan'208"; a="43013543:sNHT222633520"
Date: Thu, 8 Jul 2004 07:56:49 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Frediano Ziglio <freddyz77@tin.it>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: EDD enhanchement patch
In-Reply-To: <1089194759.4522.3.camel@freddy>
Message-ID: <Pine.LNX.4.44.0407080755270.14717-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Frediano Ziglio wrote:

> Here you are, inlined (with your change it's quite smaller)
> Fixed a stupid bug too (I'm used to code in Intel asm, not GNU asm...)
> It seems that some BIOS (like mine) fill with an invalid pointer using
> USB disks, add code to test DPTE data (using checksum).

At a glance this looks good, but I won't be able to test it myself for a 
few weeks.  If others can do so, I encourage it.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

