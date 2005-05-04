Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVEDVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEDVoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVEDVoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:44:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:47260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbVEDVnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:43:02 -0400
Date: Wed, 4 May 2005 14:43:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: vortex@scyld.com, Bogdan.Costescu@iwr.uni-heidelberg.de,
       linux-kernel@vger.kernel.org
Subject: Re: strange 3c59x behaviour under 2.6.11.7
Message-Id: <20050504144329.14908845.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0505041639400.5735@denali.ccs.neu.edu>
References: <Pine.LNX.4.44.0505031057380.9939-100000@kenzo.iwr.uni-heidelberg.de>
	<Pine.GSO.4.58.0505041639400.5735@denali.ccs.neu.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
>
> However, I found this patch (the one at the very bottom of the page):
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg78894.html
> 
> And after adapting it to the 2.6.11.7 kernel, everything works again!
> I've rebooted the machine several times, and the 3com cards initialized
> successfully every time.
> 
> I'm CC'ing linux-kernel in the hopes that this fix can make it into the
> mainstream kernel sometime soon.  I'm sure my mother would appreciate it
> greatly. :)

I was planning on merging that post-2.6.12, but I guess it looks fairly
safe...

