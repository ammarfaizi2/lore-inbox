Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRHOFeW>; Wed, 15 Aug 2001 01:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271034AbRHOFeO>; Wed, 15 Aug 2001 01:34:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47098 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271033AbRHOFdz>; Wed, 15 Aug 2001 01:33:55 -0400
Importance: Normal
Subject: Re: OT: IBM ServeRAID 2 driver
To: Jim Woodward <jim@jim.southcom.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF88DE864B.5296FE4F-ON88256AA9.001E5E7D@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Tue, 14 Aug 2001 22:33:39 -0700
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/14/2001 11:34:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For 2.4 kernels, just make sure you are running  the current version
(4.72.00) of the ips driver.
 It should be fine. Let me know if you have any troubles with it.

 - jim

Jim Woodward <jim@jim.southcom.com.au>@vger.kernel.org on 08/14/2001
10:04:07 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   Linux Kernel <linux-kernel@vger.kernel.org>
cc:
Subject:  OT: IBM ServeRAID 2 driver




Hi,

This may be a little off topic to the kernel list and may belong on a
linux-raid mailinglist, if so I  will apologise now :)

I have a client with an IBM Netfinity 5500 server which is based on a
ServeRAID 2 controller (Adaptec make the controller chip I believe)

Just wondering what the reliability and stableness of the driver for this
particular hardware is like in either 2.2 or 2.4 series kernels as linux
appears to be one of our only choices for its destined task.

It maybe best to reply off list if question is off topic?

Regards, Jim.



-
name  : Jim Woodward
www   : http://www.jim.southcom.com.au
email : jim@jim.southcom.com.au

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



