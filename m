Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUBQHml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUBQHml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:42:41 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:8417 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261877AbUBQHmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:42:40 -0500
Message-ID: <4031C5E5.9050406@cyberone.com.au>
Date: Tue, 17 Feb 2004 18:42:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Lehmann <pcg@schmorp.de>
CC: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <20040216201610.GC17015@schmorp.de>
In-Reply-To: <20040216201610.GC17015@schmorp.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Lehmann wrote:

>On Mon, Feb 16, 2004 at 07:48:19PM +0000, John Bradford <john@grabjohn.com> wrote:
>
>>Quote from Jeff Garzik <jgarzik@pobox.com>:
>>None of this is a real problem, if everything is set up correctly and
>>bug free.  Unfortunately the Just Works thing falls apart in the,
>>(frequent), instances that it's not :-(.
>>
>      
>And this is the whole point.
>
>BTW, to people trying to explain some properties of UTF-8 to me. I don't
>think ad-hominem attacks like assuming that I don't understand UTF-8
>(without any indication that this is so) are useful.
>
>The point here is that the kernel does, in a very narrow interpretation,
>not support the use of UTF-8, because proper support of UTF-8 means that
>no illegal byte sequences will be produced.
>
>

So does the kernel support the English language? Does your
email client?

