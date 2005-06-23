Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVFWITY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVFWITY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVFWIQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:16:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29874 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262544AbVFWHGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:06:32 -0400
Message-ID: <42BA5F6F.9090406@pobox.com>
Date: Thu, 23 Jun 2005 03:06:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org> <42B9FF3A.4010700@pobox.com> <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> (Of course, since the rsync protocol doesn't know anything about git
> consistency, if the mirroring is half-way, you'll end up with something
> less than wonderful, and confusing. Details, details)

Would it make sense to add an fsck step to git-clone-script?

	Jeff


