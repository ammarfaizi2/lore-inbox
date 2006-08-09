Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWHIGPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWHIGPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWHIGPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:15:16 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:48953 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030524AbWHIGPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:15:14 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nigel Cunningham <nigel@suspend2.net>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org, pavel@suse.cz
In-Reply-To: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	 <200608090750.40111.nigel@suspend2.net>
	 <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 07:14:50 +0100
Message-Id: <1155104090.5812.5.camel@insmouth>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.176
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: swsusp and suspend2 like to overheat my laptop
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> Hmm, it requires windows, and I've already wiped out that partition.
> I did a search but it seems really scary to update the BIOS via Linux.

I've done it in the past by using memdisk[0] to boot a freedos floppy
image[1] which I have added the BIOS update to... It worked but it was a
bit nerve wracking ;-)

Ian.

[0] http://syslinux.zytor.com/memdisk.php
[1] http://odin.fdos.org/odin2005/ (FWIW I used odin2880.img)

-- 
Ian Campbell

BOFH excuse #382:

Someone was smoking in the computer room and set off the halon systems.

