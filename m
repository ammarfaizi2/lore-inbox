Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbSIPWUZ>; Mon, 16 Sep 2002 18:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSIPWUY>; Mon, 16 Sep 2002 18:20:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263185AbSIPWUV>;
	Mon, 16 Sep 2002 18:20:21 -0400
Date: Mon, 16 Sep 2002 15:25:35 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020916152535.C17880@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net> <E17r2Rr-0001Vk-00@starship> <20020916150822.B17880@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020916150822.B17880@acpi.pdx.osdl.net>; from dmo@osdl.org on Mon, Sep 16, 2002 at 03:08:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel,

That last patch I sent is currently running on an
eXtremeRAID 2000 Mylex controller.
I haven't tried it yet on other controller
versions.  When you give it a try, let me know
what controller type you are using.

I thought I was having difficulties writing
new disk partitions.  But it seems to be working
fine now.  I don't know what I was seeing earlier.
I can't seem to reproduce it.

So, as far as I know, this driver is completely
functional.  I just need to complete the conversion
to using the dma interfaces, and do more rigorous
tests.

Getting test coverage on other controller versions would
be great, too.

Dave
