Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRA0LZk>; Sat, 27 Jan 2001 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130810AbRA0LZa>; Sat, 27 Jan 2001 06:25:30 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2057 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130762AbRA0LZO>;
	Sat, 27 Jan 2001 06:25:14 -0500
Date: Sat, 27 Jan 2001 22:25:02 +1100
Message-ID: <30786.980594702@ocs3.ocs-net>
From: Keith Owens <kaos@ocs3.ocs-net.redhat.com>
Subject: Re: Linux 2.4.0ac12 
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- Blind-Carbon-Copy

X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Peter Kaczuba <pepe@pool.informatik.rwth-aachen.de>
cc: "Sergey Kubushin" <ksi@cyberbills.com>
Subject: Re: Linux 2.4.0ac12 
In-reply-to: Your message of "Sat, 27 Jan 2001 12:06:57 BST."
             <20010127120657.A975@orbiter.ath.cx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jan 2001 22:25:02 +1100
Message-ID: <30786.980594702@ocs3.ocs-net>

On Sat, 27 Jan 2001 12:06:57 +0100, 
Peter Kaczuba <pepe@pool.informatik.rwth-aachen.de> wrote:
>On 2001-01-27 1:46:12 "Sergey Kubushin" <ksi@cyberbills.com> wrote:
>> Modules still don't load:
>>
>>=== Cut ===
>>ide-mod.o: Can't handle sections of type 32131
>>ide-probe-mod.o: Can't handle sections of type 256950710
>>ide-disk.o: Can't handle sections of type 688840897
>>ext2.o: Can't handle sections of type 69429248
>>=== Cut ===

Could anybody seeing this problem please pick a small object that is
failing and mail it to kaos@ocs.com.au - not to linux-kernel.  gzipped
and uuencoded preferred, I will take MIME if you have no other option.
I also need to know the versions of modutils, gcc and binutils that you
are running.


------- End of Blind-Carbon-Copy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
