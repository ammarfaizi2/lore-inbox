Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSBNBQt>; Wed, 13 Feb 2002 20:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289307AbSBNBQm>; Wed, 13 Feb 2002 20:16:42 -0500
Received: from web14401.mail.yahoo.com ([216.136.174.58]:22379 "HELO
	web14401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289294AbSBNBQc>; Wed, 13 Feb 2002 20:16:32 -0500
Message-ID: <20020214011631.38381.qmail@web14401.mail.yahoo.com>
Date: Wed, 13 Feb 2002 17:16:31 -0800 (PST)
From: Sanjeev Lakshmanan <survivor_eagles@yahoo.com>
Subject: USB device driver
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202131955210.17093-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I need to develop a USB device driver for a custom
made switch. I shall give a brief description.

 The switch (which is connected to the USB port of a
Linux box running REdHat 7.1) has four RJ 45
connectors for ethernet cables and it needs to
exchange data packets of size 8 bytes every .5
seconds. The Transmit ethernet port(1,2,3,4) and
Receive ethernet port(1,2,3,4) need to be selected for
each transfer and the data packet which is to be sent
out and received on those ports changes accordingly.

Please let me know how I can start off writing the
code for  this driver.

Also please let me know if there are any SIMILAR
device drivers already developed and available.

I am aware of the files
usr/src/linux/drivers/usb/usb.*
but as I have no prior experience with device drivers,
I am unable to start off.

Regards,
Sanjeev.




__________________________________________________
Do You Yahoo!?
Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com
