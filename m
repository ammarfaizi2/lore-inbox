Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272368AbRIFAiv>; Wed, 5 Sep 2001 20:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272369AbRIFAil>; Wed, 5 Sep 2001 20:38:41 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:44298 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S272368AbRIFAib>; Wed, 5 Sep 2001 20:38:31 -0400
Message-ID: <3B96C59A.2EC7C768@delusion.de>
Date: Thu, 06 Sep 2001 02:38:50 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB device not accepting new address
In-Reply-To: <mailman.999666181.21742.linux-kernel2news@redhat.com> <200109051619.f85GJEo07592@devserv.devel.redhat.com> <3B967EDD.5A81F2DD@delusion.de> <20010905160940.B11067@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> Interesting. I just dealt with a bug which is most definitely
> a hardware problem, and the owner swore that "it worked with
> 2.4.3-12 perfectly" (it was the last errata that we shipped).
> The thing (a Kaweth compatible Ethernet) was found NOT to work
> on earlier kernels reliably either. Such things do happen:
> something stops working just in time.
> What regressions did you do? Did you run 2.4.7-ac _after_
> it broke?

I've just tried all -ac1 kernels from 2.4.5-ac1 to 2.4.9-ac1
and the problem exists with all of them. So it would appear that
it didn't work reliably with earlier kernels either. I find it
interesting however, that it is much harder to trigger in
earlier kernels and that it doesn't happen every time.

-Udo.
