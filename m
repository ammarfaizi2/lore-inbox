Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSE2DVK>; Tue, 28 May 2002 23:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSE2DVJ>; Tue, 28 May 2002 23:21:09 -0400
Received: from h-64-105-136-78.SNVACAID.covad.net ([64.105.136.78]:35749 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313300AbSE2DVJ>; Tue, 28 May 2002 23:21:09 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 28 May 2002 20:21:02 -0700
Message-Id: <200205290321.UAA01482@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: business models [was patent stuff]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>On Tue, 2002-05-28 at 18:13, Adam J. Richter wrote:
>>       You could license all programs that consist entirely of
>> free software.  That way, BSD, LGPL, and MPL software that did
>> not link in proprietary software would be allowed too, but your
>> example of a proprietary program that linked in the BSD'ed
>> libpatent.o/c would not be covered by this permission.
>
>Define "free software" using only legally defined phrases which have
>precedent. In fact put four people in a room and get them to define free
>software.

	Many if not all legal documents contain more than
"only legally defined phrases which have precedent."  I'm sure Red Hat
has signed many.  You can reasonably find a definition that covers 99%
of what people consider free software and make subsequent grants later.
In the other direction, if you accidentally include some less than
free software, that should not matter much if you are only taking out
these patents for "defensive" purposes.

	Example definitions might be: "public domain or any license
certified by the Open Software Initiative", "a license that has
no more restrictions than version 2 of the GNU General Public License
as published by the Free Software Foundation ("or any subsequent
version"?)."  You could also cut and paste from OSI or Debian bullet
items.

	More importantly, licensing patents only for pure GPL'ed use
is unlikely to become a norm that you can expect broad adoption of
in free software businesses, as many of them tend to be proponents of
slightly different copying permissions.  If we have a bunch of patents
licensed for GPL-only, another bunch for MPL-only, another bunch for
pure-BSD only, then the patent proliferation that I described
yesterday will still probably occur.

	You have a fleeting opportunity to possibly head most of this
off, but you have to look beyond just your favorite license.  Many
developers and even companies' managements identify strongly with their
favorite licenses, and feel personally about their ability to develop
free software under those licenses.  If the GPL developers don't shield
the Apache developers, the X developers, the BSD developers, and the
MPL developers so that their ability to continue with the free software
portion of their activities has been respected, do you really think
they'll shield GPL development from their patents?

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
