Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVHEDDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVHEDDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVHEDDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:03:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262842AbVHEDCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:02:54 -0400
Date: Thu, 4 Aug 2005 20:01:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: simon.matter@invoca.ch, linux-kernel@vger.kernel.org,
       kernel-maint@redhat.com, linux-raid@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: File corruption on LVM2 on top of software RAID1
Message-Id: <20050804200139.33df1b18.akpm@osdl.org>
In-Reply-To: <20050804195853.0866ade9.akpm@osdl.org>
References: <45138.213.188.237.106.1123086677.squirrel@localhost>
	<20050804195853.0866ade9.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> There's one fix against 2.6.12.3 which is needed, but 2.6.9 didn't have the
>  bug which this fix addresses.

aargh, I see that it did fix it.

Don't blame me.  Blame people who screw up list threading by reading a
mail->news gateway and hitting "reply".

