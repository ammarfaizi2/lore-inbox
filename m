Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWJ1FcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWJ1FcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWJ1FcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:32:14 -0400
Received: from xenotime.net ([66.160.160.81]:56766 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751837AbWJ1FcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:32:13 -0400
Date: Fri, 27 Oct 2006 22:27:52 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Truong <midair77@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception on dual core Xeon
Message-Id: <20061027222752.5560ad81.rdunlap@xenotime.net>
In-Reply-To: <20061021033049.GC17706@redhat.com>
References: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com>
	<90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com>
	<20061021033049.GC17706@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 23:30:49 -0400 Dave Jones wrote:

>  > You missed the blatantly obvious error message:
>  > "This is not a software problem!"
>  > 
>  > Immediately followed by:
>  > "contact your hardware vendor"
>  > 
>  > Please follow that advice
> 
> Maybe someone needs to implement <blink> tags for printk ;-)

oops, I didn't do it for MCEs.. :)
and I used reverse video since I dislike blinking.

photo:  http://www.xenotime.net/linux/doc/kernel-msg-hilite.jpg

patch:  http://www.xenotime.net/linux/patches/kernel-hilite-msg.patch
(with caveats)

---
~Randy
