Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274667AbRJAHOP>; Mon, 1 Oct 2001 03:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRJAHOF>; Mon, 1 Oct 2001 03:14:05 -0400
Received: from zok.SGI.COM ([204.94.215.101]:54415 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274667AbRJAHNv>;
	Mon, 1 Oct 2001 03:13:51 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre1 -- depmod: Unexpected value (20) in drivers/ieee1394/sbp2.o for ieee1394_device_size 
In-Reply-To: Your message of "30 Sep 2001 23:53:22 MST."
             <1001919223.1247.13.camel@stomata.megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Oct 2001 17:13:52 +1000
Message-ID: <31455.1001920432@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2001 23:53:22 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.11-pre1; fi
>depmod: Unexpected value (20) in '/lib/modules/2.4.11-pre1/kernel/drivers/ieee1394/sbp2.o' for ieee1394_device_size

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=ieee1394+depmod&q=b
The answer is approx. number 4.

