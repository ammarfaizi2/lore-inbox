Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUH0XBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUH0XBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUH0XBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:01:43 -0400
Received: from gate.firmix.at ([80.109.18.208]:43500 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S265932AbUH0XBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:01:35 -0400
Subject: Re: Summarizing the PWC driver questions/answers
From: Bernd Petrovitsch <bernd@firmix.at>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
	 <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost>
	 <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1093647676.17366.14.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 01:01:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 00:08, Kenneth Lavrsen wrote:
> >  I have boxes where I can't run the latest version
> >of AIX any more since the hardware is no longer supported, but you don't
> >see me ripping IBM's head off for that reason.

BTW Sun did similar things with Solaris somewhere aroung 2.6 IIRC.

> Ehhh????? No comment.

Why?

[...]
> Why not let the current driver be and then work on the alternative?
> Why is it so important that it is removed now?

Because the driver's maintainer wanted it.

> Linus indicated that since Nemosoft had asked for his driver to be removed 
> noone else could take the sources as they are and add them again. So any 
> altertive would be a start from scratch? Or did I misunderstand this?

Yes, anyone - including you - can take over the maintanance of the
GPL-part of driver. Even if the former maintainer does not like it.

> That can take years. So I cannot update my kernel for years?
> How many normal users knows even how to compile their own kernel?
> You guys on this list talk as if anyone knows how to write a kernel module. 
> I think most of you have lost contact with the real users.

No, they complain all around all the time. I don't think one can loose
contact eeven if he wishes.
The point is: This is GPL software - either you do something, or someone
else does something or nothing is done. Whining doesn't help that much
compared to writing code.

> >And why is it you expect open source developers to assist in supporting
> >binary only drivers?
> 
> I am just asking for you guys to not DESTROY what is already there without 
> an alternative.

It is not destroyed, it is only in another place. Find it and put it
back whereever you need it.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


