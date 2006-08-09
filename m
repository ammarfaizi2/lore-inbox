Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWHINFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHINFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHINFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:05:53 -0400
Received: from rtr.ca ([64.26.128.89]:22489 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750748AbWHINFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:05:53 -0400
Message-ID: <44D9DDAE.8080708@rtr.ca>
Date: Wed, 09 Aug 2006 09:05:50 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: swsusp and suspend2 like to overheat my laptop
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com> <1155080145.26338.130.camel@mindpipe> <200608090942.12404.nigel@suspend2.net> <Pine.LNX.4.58.0608081948100.18586@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0608081948100.18586@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>
> I would prefer to do both, but I really can't tell you if the $OTHER_OS
> works or not. I booted it once with this machine, and that was only to
> register it with IBM. ;)
> 
> After that, I slapped in my Debian install CD and the rest is history.

My own solution for BIOS updates was to reinstall the MS stuff completely
to a small old bootable external USB drive, and place it on a shelf for
contingency / testing uses.  That way it doesn't even require a boot sector
from the main drive.

Cheers
