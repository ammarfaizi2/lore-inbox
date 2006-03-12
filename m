Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWCLRJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWCLRJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWCLRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:09:30 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:57121 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750982AbWCLRJa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:09:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a/H9ydHlRWiZc4JOaKhXuxbYKJ/Nzgp1BwYc5kxbhZXKu3HwP+HDiXQFCPpLGIb2gg8hkm0rRW6KLckntB9u89U9Q7t5PFOQCJMg8AinjmKt0Fu2UKrWjEbHDKSRCMXBTqZEDb9sU3SuIen1+hT4EIzwZ47YVtUprksTy0FjtCE=
Message-ID: <161717d50603120909w41413b00g6ad82af79b051fd3@mail.gmail.com>
Date: Sun, 12 Mar 2006 12:09:29 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: davids@webmaster.com
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060311091623.GB4087@DervishD>
	 <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, David Schwartz <davids@webmaster.com> wrote:
>
>         I advise everyone with an interest to read carefully the entire decision in
> Lexmark v. Static Controls. It clearly talks about how once you own every
> practical way to do a particular thing, you cease to be allowed to use
> copyright to do it. (Lexmark had a copyrighted Toner Loading Program in
> their print cartridges which Static Controls 'stole' to make compatible
> print cartridges. The court held that, among other things, even though the
> TLP would otherwise have been copyrightable, since it was the only practical
> way to make a cartridge work with certain Lexmark printers, copyright was
> not applicable.)

Static Controls also explicitly says that the analysis of whether
scenes a faire applies is vastly different for a work of greater
complexity and size than the TLP ("Neither do the cited cases support
the district court's initial frame of reference. [cases cited],
involved copies of Apple's operating system program -- a program whose
size and complexity is to the Toner Loading Program what the Sears
Tower is to a lamppost. Given the nature of the Apple program, it
would have been exceedingly difficult to say that practical
alternative means of expression did not exist...").

Thanks for the citation and the legal analysis, David. I've found your
posts insightful and educational, but after reading more I still come
away thinking you've missed the essential point that the Linux
operating system, and in particular the means that internal parts of
the system communicate with each other (essential to modules) are
inherently part of the expressive content of Linux, not dictated by
external factors, and that modules are indeed derived works of the
kernel and hence subject to infringement claims if the license terms
aren't met.

Ciao,
Dave
