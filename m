Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263834AbUEGWuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUEGWuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUEGWuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:50:32 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:15513 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263834AbUEGWub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:50:31 -0400
Date: Fri, 7 May 2004 23:49:50 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Ian Kent <raven@themaw.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux autofs <autofs@linux.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [autofs] Badness in interruptible_sleep_on
In-Reply-To: <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
Message-ID: <Pine.LNX.4.58.0405072321530.1979@fogarty.jakma.org>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
 <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Ian Kent wrote:

> Not sure what needs to be done about this Paul.
> 
> I eliminated the interruptible_sleep_on in my autofs4 patches long
> ago.  The current updates are in 2.6.6-rc3-mm2.

Ah excellent news. I'm using Arjan van de Ven's 2.6.3-1.96 kernel at 
the moment. So that problem will dissappear with a kernel update at 
some stage. Thanks!

PS: Arjan, any chance of a kernel with davej's NFS stack fixes and 
the autofs badness fixes? would be much appreciated!
 
regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
If you analyse anything, you destroy it.
		-- Arthur Miller
