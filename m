Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265376AbRF0TXv>; Wed, 27 Jun 2001 15:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbRF0TXl>; Wed, 27 Jun 2001 15:23:41 -0400
Received: from web4001.mail.yahoo.com ([216.115.104.35]:2313 "HELO
	web4001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265376AbRF0TX2>; Wed, 27 Jun 2001 15:23:28 -0400
Message-ID: <20010627192327.23875.qmail@web4001.mail.yahoo.com>
Date: Wed, 27 Jun 2001 12:23:27 -0700 (PDT)
From: Prasad Koya <kdp102@yahoo.com>
Subject: BSD sockets with sys_socketcall 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does socket(), bind() and other BSD socket API
calls in user applications are handled by system
socketcall(). Does the compiler (say gcc) substitute
socket() in user app with socketcall(SYS_SOCKET,..)?

Also, why don't I see _syscallN() macro for socketcall
or any other BSD socket calls? 

I'd greatly appreciate your help.

Please CC to kdp102@yahoo.com as I don't subscribe to
the mailing list.

Thanks


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
