Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKJKNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKJKNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKJKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:13:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbVKJKN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:13:29 -0500
Date: Thu, 10 Nov 2005 02:12:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: zach@vmware.com
Cc: sam@ravnborg.org, rmk@arm.linux.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com, than@redhat.com
Subject: Re: [PATCH 1/1] My tools break here
Message-Id: <20051110021255.3cf79cee.akpm@osdl.org>
In-Reply-To: <20051107150807.5f85ec13.akpm@osdl.org>
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com>
	<20051107225024.GB10492@mars.ravnborg.org>
	<20051107150807.5f85ec13.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> > The change has been in -git for a full day and in latest -mm too.
>  > And so far this is the only report that it breaks - I no one else
>  > complains it will stay.
> 
>  Let's wait and see how many more people are affected.

duh.  The next bunny is me.

/usr/local/gcc-3.2.1/lib/gcc-lib/i686-pc-linux-gnu/3.2.1/tradcpp0: output filename specified twice

That's a vanilla gcc-3.2.1

Is there any downside to using -include?
