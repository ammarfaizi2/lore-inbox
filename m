Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRKJRKA>; Sat, 10 Nov 2001 12:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277532AbRKJRJv>; Sat, 10 Nov 2001 12:09:51 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:62733 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274434AbRKJRJf>; Sat, 10 Nov 2001 12:09:35 -0500
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Sat, 10 Nov 2001 17:09:40 +0000
From: quintaq@yahoo.co.uk
To: linux-kernel@vger.kernel.org
Subject: Problems creating filsystems and with dd
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20011110170944Z274434-17408+13076@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Responding to my own post under this heading, I googled my way to Peter
Seiderers recent posts under "What is the difference between 'login: root'
and 'su -' ?".  I find that dd works when I login as root rather than su. 
FWIW I also worked out that, when using su, dd was failing on the 2GB
boundary.  Anyway, whatever the causes, that seems to solve my problem from
a practical point of view.

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

