Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUHWUt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUHWUt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUHWUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:47:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267785AbUHWUpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:45:23 -0400
Date: Mon, 23 Aug 2004 13:45:13 -0700
From: cliff white <cliffw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidw@dedasys.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Incompatibility List
Message-Id: <20040823134513.7ee62d81.cliffw@osdl.org>
In-Reply-To: <1093207525.25067.12.camel@localhost.localdomain>
References: <87r7q0th2n.fsf@dedasys.com>
	<1093173291.24341.40.camel@localhost.localdomain>
	<87vffaq4p1.fsf@dedasys.com>
	<1093207525.25067.12.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 21:45:27 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sul, 2004-08-22 at 21:48, David N. Welton wrote:
> > A "compatibility list" is going to be pretty big, and hard to keep up
> > to date.  My thinking is that keeping track of a few notable things
> > that don't work is easier than running after all the stuff that does.
> 
> Its already been kicked around on the Fedora list to actually build such
> a database automatically. I've seen similar Debian proposals a long time
> ago. That means some time post install you'd let the user
> fire up a system report tool which would ask things like
> 
> 	"Does sound work"
> 
> and then fire off PCI id/rating info to a central site. That would help
> deal with the data collection much as the Debian folks collect package
> popularity statistics.
> 
> > I suppose some sort of vote system could be put in place so that the 1
> > guy who didn't get the hardware to work gets outvoted by the 10 who
> > did, but there is more incentive to hit the button when you are
> > irritated than when everything 'just worked'.
> 
> If you get enough data then the deviation tells you how varied and how
> reliable the opinions are likely to be, all this implies databases not
> WIki however
> 
This sounds very interesting indeed. We (OSDL) have been talking about how to
extend our testing into the ISV space, and how to supply useful data. This 
type of post-install, post-test 'i look like this, and this runs' data capture
would be real useful, especially if we could capture software info also.
Who else was interested in this?
cliffw

> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
