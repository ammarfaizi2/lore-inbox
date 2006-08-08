Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWHHXbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWHHXbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWHHXbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:31:50 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28626 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965072AbWHHXbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:31:49 -0400
Date: Tue, 8 Aug 2006 19:31:30 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nigel Cunningham <nigel@suspend2.net>
cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: swsusp and suspend2 like to overheat my laptop
In-Reply-To: <200608090750.40111.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
 <200608090750.40111.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Aug 2006, Nigel Cunningham wrote:

>
> The problem will be ACPI related, not particular to swsusp or Suspend2, which
> is why you're seeing it with both implementations. I would suggest that you
> contact the ACPI guys, and also look to see whether there is a bios update
> available and/or a DSDT override for your machine. The later will help if the
> problem is with your particular machine's ACPI support, the former if it's a
> more general ACPI issue.
>

Thanks for the response Nigel,

There does exist a recent bios update for this machine:

http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=lenovo&lndocid=MIGR-58127

Hmm, it requires windows, and I've already wiped out that partition.  I
did a search but it seems really scary to update the BIOS via Linux.

Anyone else out there have a Thinkpad G41 and has successfully upgraded
their BIOS?

Thanks,

-- Steve

