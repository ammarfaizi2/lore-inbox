Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285410AbRLGEgw>; Thu, 6 Dec 2001 23:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285409AbRLGEge>; Thu, 6 Dec 2001 23:36:34 -0500
Received: from rj.sgi.com ([204.94.215.100]:19412 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285405AbRLGEg0>;
	Thu, 6 Dec 2001 23:36:26 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] (no subject) 
In-Reply-To: Your message of "Thu, 06 Dec 2001 21:30:59 PDT."
             <20011207043059.GI30935@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 15:36:13 +1100
Message-ID: <24800.1007699773@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 21:30:59 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>On Fri, Dec 07, 2001 at 03:17:53PM +1100, Keith Owens wrote:
>> 2.5.2-pre1      Add the kbuild 2.5 and CML2 code, still using
>>                 Makefile-2.5, supporting both CML1 and CML2.
>>                 i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
>>                 2.5 is recommended.
>>                 ia64 can only use kbuild 2.5.
>>                 Other architectures continue to use kbuild 2.4.
>>                 Wait 24 hours for any major problems then -
>
>Could we wait longer here?  Maybe 48 or 72 to give other arches time to
>convert and attempt to sync again?  Or at least show it to Keith so he
>can try and sync it up. :)

We will not get all architectures converted in 48 hours or even 72.
kbuild 2.5 has been available for months and only i386, ia64, sparc32
(I did all those) and sparc64 (Ben Collins) have been converted.  Alpha
is in progress.  Unconverted architectures stay on 2.5.2-pre1 until
they do the conversion, but there is no need to hold up everybody else.

