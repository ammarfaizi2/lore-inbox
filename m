Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130868AbQKJWEw>; Fri, 10 Nov 2000 17:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbQKJWEn>; Fri, 10 Nov 2000 17:04:43 -0500
Received: from euclid.cs.niu.edu ([131.156.145.14]:64468 "EHLO
	euclid.cs.niu.edu") by vger.kernel.org with ESMTP
	id <S130868AbQKJWEi>; Fri, 10 Nov 2000 17:04:38 -0500
X-Mailer: exmh version 2.1.2 06/08/2000
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
Reply-To: sendmail-bugs@sendmail.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue 
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@timpanogas.org> 
   of "Fri, 10 Nov 2000 14:52:01 MST." <3A0C6E01.EFA10590@timpanogas.org> 
Date: Fri, 10 Nov 2000 16:03:55 -0600
Message-ID: <26054.973893835@euclid.cs.niu.edu>
From: Neil W Rickert <sendmail+rickert@sendmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:

>The problem of dropping connections on 2.4 was related to the O RefuseLA
>settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
>clearly set too low for modern Linux kernels.  You may want them cranked
>up to 100 or something if you want sendmail to always work.  

If a modern Linux kernel requires high load average defaults, I will
stop using Linux.

 -NWR

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
