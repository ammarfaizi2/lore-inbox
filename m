Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUJCXTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUJCXTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUJCXTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:19:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45723 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268229AbUJCXS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:18:58 -0400
Subject: Re: Merging DRM and fbdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vladimir Dergachev <volodya@mindspring.com>,
       Dave Airlie <airlied@linux.ie>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391041003154231bcccd8@mail.gmail.com>
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
	 <9e4733910410030833e8a6683@mail.gmail.com>
	 <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
	 <9e4733910410030924214dd3e3@mail.gmail.com>
	 <Pine.LNX.4.61.0410031254280.17448@node2.an-vo.com>
	 <9e473391041003105511b77003@mail.gmail.com>
	 <Pine.LNX.4.61.0410031636320.18135@node2.an-vo.com>
	 <9e473391041003154231bcccd8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096841762.16457.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 03 Oct 2004 23:16:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-03 at 23:42, Jon Smirl wrote:
> Is there are device driver level interface defined for controlling
> tuners?

Both at the Xv and the kernel level yes.

