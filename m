Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUGUTzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUGUTzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUGUTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:55:35 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:36518 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266609AbUGUTze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:55:34 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
In-Reply-To: <20040721182535.GC16838@kroah.com>
References: <20040721141524.GA12564@kroah.com> <E1BnIHx-0003Py-00@chiark.greenend.org.uk> <E1BnIHx-0003Py-00@chiark.greenend.org.uk> <20040721182535.GC16838@kroah.com>
Message-Id: <E1BnNBd-0008Ad-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 21 Jul 2004 20:55:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>On Wed, Jul 21, 2004 at 03:41:45PM +0100, Matthew Garrett wrote:
>> The new Debian installer requires devfs on several architectures, even
>> for 2.6 installs. That's unlikely to get changed before release.
>
>Great, if you want to rely on this, and you get around to using a kernel
>that doesn't have it in it, just add it to the other patches you apply
>to your kernel.

Oh, sure, I've no objection to the damn thing dying - it was just to
point out that (rightly or wrongly) there /is/ someone using it.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
