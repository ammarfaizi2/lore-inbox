Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268778AbRHBFlu>; Thu, 2 Aug 2001 01:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268779AbRHBFlj>; Thu, 2 Aug 2001 01:41:39 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:3712 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S268778AbRHBFli>; Thu, 2 Aug 2001 01:41:38 -0400
Message-ID: <3B68E74B.E4A9E481@randomlogic.com>
Date: Wed, 01 Aug 2001 22:38:19 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OT: Virii on vger.kernel.org lists
In-Reply-To: <Pine.LNX.4.33.0108011406320.15992-100000@sol.compendium-tech.com> <Pine.GSO.4.21.0108011713080.27494-100000@weyl.math.psu.edu> <20010801235724.A23000@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 

[SNIP]
> 
> That is the always repeated answer. I could get a web page at some box at the
> University, but there are many people that have not a permanent address. Going
> to the mess of using a ISP-provided web page is a pain. Instead of bzip your
> patch and send it to the list you have to go through bizarre http interfaces
> to manage your web page (tell me about a ISP that lets you telnet/ssh/ftp to your
> account).
> 
> I do not see why a bzipped patch is so bad. The only person I was aware he won't
> read anything but plain text is Linus (and now some on this thread look with
> the same feeling).
> 

There are a few reasons why zipped attachments, large attachments, and
even large text-only patches are bad on a mailing list such as this:

1. Not everyone uses a mail client that will support the various
attachment encodings and therefore can not get the attachment without
jumping through hoops. Why subject them to this?

2. Some mail clients pervert the standard attachment formats, such as
Outlook Express, making them undecipherable by anyone using anything
other than that very same client. Again, why subject people to that?

3. Many, many people PAY PER BYTE for their Internet connection. Adding
a large attachment, or sending a large text patch file, costs them
money. Many times they do not want it anyway and you are costing them
money by forcing them to D/L it.

4. Not everyone has a high speed connection and with the volume that a
list like this creates, it is a LARGE burden on them to wait, and wait,
and wait, for the few messages they want, and/or need, to see.

So, as with other large projects I've worked on (though none quite this
large) involving a mailing list, the best solution is to a) strip
attachments atthe mailing list server and b) provide a repository for
people to D/L patches, new kernels, etc. for public access.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
