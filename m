Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSEMTCB>; Mon, 13 May 2002 15:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSEMTCA>; Mon, 13 May 2002 15:02:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30479 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314379AbSEMTCA>;
	Mon, 13 May 2002 15:02:00 -0400
Message-ID: <3CE00D53.8000503@mandrakesoft.com>
Date: Mon, 13 May 2002 15:00:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE> <abn6q9$umv$1@penguin.transmeta.com> <3CDF4AAE.1020605@mandrakesoft.com> <3CDF9760.FF53DDF7@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

>Jeff Garzik wrote:
>
>>(speaking more to the crowd...)
>>Changeset comments need to be written as if they stand alone, without
>>any other context -- including the author.  A reader should not need to
>>know that (for examples) James Simmons hacks on fbdev stuff.
>>
>
>I think it is nice to have the names.  A new kernel
>might break something,  It is then nice to know
>where to send the bug report. (It is usually, but not
>necessarily the maintainer that did it.)
>

Having the name is fine -- I agree it should not be removed.

However, that was not the point of my message.  The point is, each 
changeset comment comes with -no context at all-.  If the author of the 
comment assumes that, by his name, we can figure out what a comment like 
"minor fixes" mean, that author is making a mistake.  Each cset comment 
needs to tell exactly what the change is, and should not require 
knowledge of the author's identity to determine what is in the changeset.

    Jeff



