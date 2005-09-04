Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVIDVf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVIDVf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIDVf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:35:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbVIDVf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:35:28 -0400
Date: Sun, 4 Sep 2005 14:30:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-Id: <20050904143033.13a4bed3.akpm@osdl.org>
In-Reply-To: <9a87484905090414245589a3c@mail.gmail.com>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<20050903122126.GM3657@stusta.de>
	<20050903123410.1320f8ab.akpm@osdl.org>
	<20050903195423.GP3657@stusta.de>
	<20050903130632.3124e19b.akpm@osdl.org>
	<9a87484905090414245589a3c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> I'm wondering if it would be too much trouble to have a mm-drops list
>  similar to the mm-commits list.

Well I was sending drop messages to mm-commits, but lots of people went
"Waah, why did you drop my patch?".  A few hours after they'd been cc'ed as
the patch went in to Linus!  So then I was asked to include an explanation
with the drop message and that all got too hard so I turned them off.

<turns them back on again>

>  I also like to keep track of what patches of mine get accepted and
>  subsequently dropped.

As I say, the way to do this is via your quilt series file.

