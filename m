Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRGYPNu>; Wed, 25 Jul 2001 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbRGYPNl>; Wed, 25 Jul 2001 11:13:41 -0400
Received: from patan.Sun.COM ([192.18.98.43]:10372 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S266970AbRGYPN2>;
	Wed, 25 Jul 2001 11:13:28 -0400
Message-ID: <3B5EE21B.D90B2A13@Sun.COM>
Date: Wed, 25 Jul 2001 17:13:31 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: SO_BINDTODEVICE and IP tunneling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi folks,

Does anyobody knows if there is an incompatibility in binding a TCP/UDP
socket to a tunnel IPIP, with setsockopt(fd, SOL_SOCKET,
SO_BINDTODEVICE...).

Tnx.

-- 
"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.
--

    Julien Laganier
     Student Intern
Sun Microsystem Laboratories
