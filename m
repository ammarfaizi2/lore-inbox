Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291631AbSBMIUP>; Wed, 13 Feb 2002 03:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBMIUF>; Wed, 13 Feb 2002 03:20:05 -0500
Received: from web14407.mail.yahoo.com ([216.136.174.77]:13330 "HELO
	web14407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291455AbSBMIT5>; Wed, 13 Feb 2002 03:19:57 -0500
Message-ID: <20020213081956.12896.qmail@web14407.mail.yahoo.com>
Date: Wed, 13 Feb 2002 00:19:56 -0800 (PST)
From: Sanjeev Lakshmanan <survivor_eagles@yahoo.com>
Subject: USB device driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi all
 
 I need to develop a USB device driver for a custom
 made switch. I shall give a brief description.
 
 The switch has four RJ 45 connectors for ethernet
 cables and it needs to exchange data packets of size
 8 bytes every .5 seconds. The Transmit ethernet
 port(1,2,3,4) and Receive ethernet port(1,2,3,4)
 need to be selected for each transfer and the data   
  packet which is to be sent out and received on those
   ports changes accordingly.
 
 Please let me know how I can start off writing the
 code for  this driver.
 Also please let me know if there are any SIMILAR
 device drivers already developed and available.
 
 I am aware of the files
 usr/src/linux/drivers/usb/usb.*
 but as I have no prior experience with device
drivers,  I am unable to start off.

 I have not yet subscribed to the list. PLease reply
to  survivor_eagles@yahoo.com

 Regards,
 Sanjeev.
 
 


__________________________________________________
Do You Yahoo!?
Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com
