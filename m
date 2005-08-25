Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVHYMUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVHYMUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVHYMUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:20:55 -0400
Received: from web8401.mail.in.yahoo.com ([202.43.219.149]:34922 "HELO
	web8401.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S964954AbVHYMUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:20:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C3CwVnZ48EKZhHB1TG+TD0Cgs6kJjL63zgEG/6nk4vIhj8pz8DaV6XVqPYse1yz1hFCTNnlnLsKChiBDIwwD4NTw/9LwmQXdUH3GsP1dOXZp0Jf6wNMiQJm1OTMWTmQw9IX2WzFJsKmvVkffc2DCJtXiNlAUdAXB9O3kIv2Kle0=  ;
Message-ID: <20050825122045.57008.qmail@web8401.mail.in.yahoo.com>
Date: Thu, 25 Aug 2005 13:20:45 +0100 (BST)
From: Rahul Tank <rahul5311@yahoo.co.in>
Subject: serial port multiplexing
To: Linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello all,

    I am a newbee tryinging for serial port
multiplexing. Currently my driver supports for one
port
(/dev/ttyS0). However i want to use the same physical
port for 2 virtual ports.I am NOT sending two type of
data simultaneously. I want to first reigister my
driver for /dev/ttyS0. When the kernel  has booted ,i
want to disable it. Then i want to enable the driver
to register for say /dev/ttyS1.
  in short i don't want the console to have controle
over the serial port.
  The point of doing such is that i want my serial
port to be free. I can telnet to this potr from other
machine and test few stuff. i hope i have properly
mentioned my problem.

 plz let me know how should i proceed.
 thanks in advance.

 regards,
  rahul





	

	
		
____________________________________________________
Send a rakhi to your brother, buy gifts and win attractive prizes. Log on to http://in.promos.yahoo.com/rakhi/index.html
