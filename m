Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWFTI44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWFTI44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFTI4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:56:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965219AbWFTI4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:56:55 -0400
Date: Tue, 20 Jun 2006 01:56:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: andi@lisas.de
Cc: andim2@users.sourceforge.net, linux-kernel@vger.kernel.org,
       hal@lists.freedesktop.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD
 hard resets)
Message-Id: <20060620015641.98368543.akpm@osdl.org>
In-Reply-To: <20060620084759.GA798@rhlx01.fht-esslingen.de>
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
	<20060620013741.8e0e4a22.akpm@osdl.org>
	<20060620084759.GA798@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 10:47:59 +0200
Andreas Mohr <andim2@users.sourceforge.net> wrote:

> Just filed this as
> http://bugzilla.kernel.org/show_bug.cgi?id=6722
> due to no response here before.

I saw it, which is why I hunted down this email.  I hadn't even got that
far into my lkml reading, actually.  You should wait 2-3 days to be really
sure that a bug is being ignored.  Although with one like this, it's a fair
bet that it will be.

> (#6194 looks like it might be the same issue)
> 
> I'd suggest continuing discussion at bug #6722 from now.

No, I tend to think it's better to resort to bugzilla only after a few
days, when the trail has gone cold.
