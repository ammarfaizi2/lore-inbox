Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEFz4>; Fri, 5 Jan 2001 00:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEFzr>; Fri, 5 Jan 2001 00:55:47 -0500
Received: from ns1.megapath.net ([216.200.176.4]:24592 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129183AbRAEFzc>;
	Fri, 5 Jan 2001 00:55:32 -0500
Message-ID: <3A556195.5090902@megapathdsl.net>
Date: Thu, 04 Jan 2001 21:54:29 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac1
In-Reply-To: <E14EMin-0006t7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error when attempting to compile.
I ran:

	make mrproper
	cp ../.config .
	make oldconfig
	make dep

make[4]: Entering directory `/usr/src/linux/drivers/acpi'
/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references itself (eventually).  Stop.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
