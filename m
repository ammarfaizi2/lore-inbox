Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSGWQlk>; Tue, 23 Jul 2002 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318156AbSGWQlk>; Tue, 23 Jul 2002 12:41:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2433 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S318155AbSGWQlj>; Tue, 23 Jul 2002 12:41:39 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: "Timothy D. Witham" <wookie@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1027258811.17234.90.camel@irongate.swansea.linux.org.uk>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel
	 >
	<1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.ke
	 rnel>  <p731y9xva8m.fsf@oldwotan.suse.de> 
	<1027258811.17234.90.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 09:41:49 -0700
Message-Id: <1027442509.1911.16.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It is more like EVMS has safety devices to prevent people from
getting caught up in the machinery.  In that respect it keeps
people from hurting themselves. And even if it is only when 
the are tired or in a hurry it is worth the effort. When you
have several 100 servers that you need to take care of any
help is appreciate.

Since most data loss is human error having a volume manager to 
enable people to have higher availability and not addressing 
the number one cause of data loss doesn't seem to make sense to 
me.

 
On Sun, 2002-07-21 at 06:40, Alan Cox wrote:
> On Sun, 2002-07-21 at 07:57, Andi Kleen wrote:
> > One disadvantage of the LVM2 concept is that it relies a lot on compatible
> > user space and there is unlikely to be a stable API. While I'm normally
> > all for putting things in user space where it makes sense I think the
> > mounting of your root file system is a bit of exception. 
> 
> LVM2 relies on people doing things right so we shouldnt use it ? 
> 
> Strange
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

