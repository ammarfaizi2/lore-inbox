Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTHGPmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTHGPmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:42:45 -0400
Received: from [81.173.206.50] ([81.173.206.50]:57425 "EHLO
	sun.richardstevens.de") by vger.kernel.org with ESMTP
	id S265531AbTHGPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:41:59 -0400
From: Richard Stevens <mail@richardstevens.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Newbie debugging question
Date: Thu, 7 Aug 2003 17:41:32 +0200
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>
References: <200308070230.49802.mail@richardstevens.de> <32841.4.4.25.4.1060233933.squirrel@www.osdl.org>
In-Reply-To: <32841.4.4.25.4.1060233933.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071741.55548.mail@richardstevens.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> I suggest asking on the kernelnewbies mailing list (see kernelnewbies.org).
> Also, some people started on this web page, but it's only a beginning:
>   http://lse.sourceforge.net/debugging/

thanks for the info. I'll do that. 

> What kernel version?  That would have some effects on the answer.

2.4.21 vanilla (now with the latest version of sgi's kdb)

>
> Serial console is the usual option/route.  If it boots completely,
> you could also try netconsole (or, dare I say it, usb console).
> Or LKCD (lkcd.sf.net), or kmsgdump (2.5.75/2.6.0 at
> http://www.xenotime.net/linux/kmsgdump/2.5.75/).

I'll check these. I managed to get some information via kdb and serial 
console. Don't know if it is useful but I guess they will tell me :-)

Thanks again,

Richard


PS: In case of answers to this, please CC me since I'm not subscribed.

