Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280748AbRKSWHA>; Mon, 19 Nov 2001 17:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKSWGw>; Mon, 19 Nov 2001 17:06:52 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:40148 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280748AbRKSWGn>;
	Mon, 19 Nov 2001 17:06:43 -0500
Date: Mon, 19 Nov 2001 22:06:38 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
Message-ID: <1925755060.1006207598@[195.224.237.69]>
In-Reply-To: <E165w5m-0007mR-00@the-village.bc.nu>
In-Reply-To: <E165w5m-0007mR-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

>> Which trademark law are you violating by having that in a directory
>> name path, which you are not also violating by having it in the
>> kernel source, make config, name of the module and its printk()
>> on load, etc. etc.
>
> You can change all the other names with almost zero impact

Ah - OK; dname/dt didn't occur to me, but still this is
a consequence of a violation, not the violation itself; what
aspect of trademark law is a problem?

There are a few other examples of this. /proc/cpuinfo has

shed[amb].121$ cat /proc/cpuinfo
...
vendor_id       : GenuineIntel
...
model name      : Pentium III (Coppermine)

That's 2, if not 3 trademarks without acknowledgement that
might be searched for by userspace programs.

The solution is presumably that lanana doesn't accept /registered/
trademarks without a GPL compatible license from the trademark
holder. I don't believe you would have too much of a problem
with unregistered trademarks.

In any case, most trademark law has some concept of 'fair use'.
See the difficulty many trademark holders have in suing
registrants of [trademark]sucks.[registrysuffix]. I think
the use in terms of supporting hardware is pretty
fair. Cloning competing OS functionality is closer to
the wind I admit.

(Only tangentially relevant but for amusement value and a
 beautifully argued case read
  http://arbiter.wipo.int/domains/decisions/html/2001/d2001-0918.html
 enjoyment almost guaranteed
)

--
Alex Bligh
