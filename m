Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbREUGsM>; Mon, 21 May 2001 02:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261680AbREUGsC>; Mon, 21 May 2001 02:48:02 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:49437 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S261679AbREUGrz>; Mon, 21 May 2001 02:47:55 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Allan Duncan <b372050@vus068.trl.telstra.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile failure in 2.4.5-pre4 
In-Reply-To: Your message of "Mon, 21 May 2001 16:38:45 +1000."
             <200105210638.QAA19887@vus068.trl.telstra.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 16:47:45 +1000
Message-ID: <1380.990427665@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 101 16:38:45 +1000 (EST), 
Allan Duncan <b372050@vus068.trl.telstra.com.au> wrote:
>drivers/ide/ide-pci.c:711
>    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)

for (i = 0; i < 1000; ++i)
  printf("I must scan kernel archives before report bugs\n");

http://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg45470.html

>Allan Duncan  b372050@vus068.trl.telstra.com.au  (+613) 9253 6708, Fax 9253 6775
>     (We are just a number)

Who is number 1?
You are number 6.
I am not a number, I am a free man!

