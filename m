Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbQJ1Ubo>; Sat, 28 Oct 2000 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130854AbQJ1Ubf>; Sat, 28 Oct 2000 16:31:35 -0400
Received: from mail.bilboul.com ([193.117.73.30]:40044 "EHLO www.bilboul.com")
	by vger.kernel.org with ESMTP id <S130478AbQJ1UbR>;
	Sat, 28 Oct 2000 16:31:17 -0400
Newsgroups: localnet.mail.linux.kernel
Path: sweh
From: sweh@spuddy.mew.co.uk (Stephen Harris)
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
Message-ID: <G35ns0.3rD@spuddy.mew.co.uk>
Organization: Spud's Public Usenet Domain
X-Newsreader: TIN [version 1.2 PL2]
In-Reply-To: <G31psL.73r@spuddy.mew.co.uk>
Date: Sat, 28 Oct 2000 19:36:00 GMT
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of talk here has been about syslog and DNS blocking, but the
original message mentioned:

> If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
> kernel 2.2.x), within a few minutes you will find your entire machine
> grinds to a halt.  For example, nobody can log in.

Has this been addressed (and I missed it) or did the question get
diverted?  If it has been addressed, just please mail me personally to
save traffic on the list.

Thanks!
-- 
                                 Stephen Harris
                 sweh@spuddy.mew.co.uk   http://www.spuddy.org/
      The truth is the truth, and opinion just opinion.  But what is what?
       My employer pays to ignore my opinions; you get to do it for free.      
  * Meeeeow ! Call  Spud the Cat on > 01708 442043 < for free Usenet access *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
