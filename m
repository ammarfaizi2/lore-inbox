Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRLQWy5>; Mon, 17 Dec 2001 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282993AbRLQWyr>; Mon, 17 Dec 2001 17:54:47 -0500
Received: from web10408.mail.yahoo.com ([216.136.130.110]:48390 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283001AbRLQWyk>; Mon, 17 Dec 2001 17:54:40 -0500
Message-ID: <20011217225439.67165.qmail@web10408.mail.yahoo.com>
Date: Tue, 18 Dec 2001 09:54:39 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4.16: Out of memory - when still more than 100MB free
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

As I tested 2.4.17-rc1, I think the OOM is still not
right working, In a session StarOffice got killed when
there is still a lot memory available. But strange
enough, 2.4.16 seems to be better in the same
situation. Another issue; because after that I restart
staroffice and mount floppy ; read a file from floppy,
because of a bug in Star office (I think ) when I save
file to the floppy from star office, star office hang,
no responsive at all. I have to kill staroffice but it
doesn't work, even I use signal 9. Then I try to
repeat this under 2.4.16, it did not happen (kill
works)

Regards,



=====
S.KIEU

http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your festive greetings online!
