Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUINW3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUINW3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUINWXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:23:42 -0400
Received: from mail.broadpark.no ([217.13.4.2]:38063 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S269597AbUINWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:21:41 -0400
Message-ID: <41476F6E.8030205@linux-user.net>
Date: Wed, 15 Sep 2004 00:23:42 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] README (resend) - Explain new 2.6.xx.x version number
References: <41476413.1060100@linux-user.net> <20040914214356.GG13788@redhat.com>
In-Reply-To: <20040914214356.GG13788@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Sep 14, 2004 at 11:35:15PM +0200, Daniel Andersen wrote:
> 
>  > +   In case of a
>  > +   bug-fix release such as if eg. 2.6.8.2 is released after 2.6.9 has
>  > +   been released, 2.6.9 is still to be considered the newest kernel
>  > +   release of all current kernels.
> 
> This bit seems odd to me. Why would a 2.6.8.2 get released, when there's
> a newer 2.6.9 which should fix whatever was relevant to get into 2.6.8.x ?
> 
> 		Dave
> 

This was discussed in the thread "Linux 2.6.9-rc1". Linus said there was 
a remote possibility it could happen some day so I thought it was a good 
thing to mention.

Daniel Andersen

--
