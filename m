Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314681AbSDTRtM>; Sat, 20 Apr 2002 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSDTRtL>; Sat, 20 Apr 2002 13:49:11 -0400
Received: from relay1.pair.com ([209.68.1.20]:56847 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314681AbSDTRtK>;
	Sat, 20 Apr 2002 13:49:10 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC1AA5C.1DE5C69D@kegel.com>
Date: Sat, 20 Apr 2002 10:50:20 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: idea to enhance get_pid()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Aloni wrote:
> The last time I checked, the only thing that stops the move back to
> 32-bit pids is a bug in the bash shell, and just a few workable IPC
> interfaces and libc breakages.

I'd like to know more about that bash bug; do you have a URL for it?
(Is there even a bug tracking system for bash?)
I looked a bit on gnu.bash.bugs, and found two possibly related
patches; do these have anything to do with the bug?
http://groups.google.com/groups?selm=200104130734.AAA12931%40shade.twinsun.com
http://groups.google.com/groups?selm=200104130854.BAA18368%40shade.twinsun.com

Thanks,
Dan
