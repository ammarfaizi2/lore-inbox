Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSILVlO>; Thu, 12 Sep 2002 17:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSILVlN>; Thu, 12 Sep 2002 17:41:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16638 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317349AbSILVlN>; Thu, 12 Sep 2002 17:41:13 -0400
Subject: 
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, <riel@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF7E3379EC.41D998B8-ON88256C32.0075ED3F@boulder.ibm.com>
From: "Jim Sibley" <jlsibley@us.ibm.com>
Date: Thu, 12 Sep 2002 14:41:18 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/12/2002 03:45:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Only if you assume that a bunch of users tries very hard to use up all the

resources...

Not true. A sudden surge in legitmate traffic can stretch the limits
unwittingly or a new legitmate appliation can stretch the limits in an
unexpected way. If there is such a surge, who has priority?

I have cause similar random behaviour 1) if I have a lot users doing little
things, 2) a few big users doing big things, 3) a  mix of users doing
various things or 4) one  users doing bad things. And in any of the cases,
I have no say in whose going to get killed.

And I don't have to try very hard and I don't have to be the super user.

Regards, Jim
Linux S/390-zSeries Support, SEEL, IBM Silicon Valley Labs
t/l 543-4021, 408-463-4021, jlsibley@us.ibm.com
*** Grace Happens ***



