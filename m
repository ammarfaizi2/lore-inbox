Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDMWPq>; Fri, 13 Apr 2001 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRDMWPg>; Fri, 13 Apr 2001 18:15:36 -0400
Received: from smtp04.wxs.nl ([195.121.6.59]:42480 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S132027AbRDMWPX>;
	Fri, 13 Apr 2001 18:15:23 -0400
Message-ID: <3AD77A94.E05E1BE2@planet.nl>
Date: Sat, 14 Apr 2001 00:15:48 +0200
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <m14o9LX-000Od4C@amadeus.home.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That would be great!!!!!
finally someone is coming to the rescue
do you have the source files or are you going to work from scratch?

Erik

Arjan van de Ven schreef:

> In article <3AD6B422.EEC092F0@ftel.co.uk> you wrote:
> > Andre Hedrick wrote:
>
> > However as far as I can see everyone who has a FastTrak which is "stuck"
> > in RAID mode[1] would be happy if it worked as a normal IDE controller
> > in Linux, which is (usually?) not the case - eg on the MSI board where
> > only the first channel is seen.
>
> I have a patch to work around that. However the better solution would be to
> have a native driver for the raid; I plan to start working on that next
> week...
>
> Greetings,
>   Arjan van de Ven
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

