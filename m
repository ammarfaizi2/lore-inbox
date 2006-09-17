Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWIQPTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWIQPTi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWIQPTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:19:38 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:3033 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S964819AbWIQPTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:19:37 -0400
Message-ID: <450D6786.7010404@comcast.net>
Date: Sun, 17 Sep 2006 11:19:34 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler tunables?
References: <450C8680.6050904@comcast.net> <1158483845.6025.22.camel@Homer.simpson.net>
In-Reply-To: <1158483845.6025.22.camel@Homer.simpson.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Mike Galbraith wrote:
> On Sat, 2006-09-16 at 19:19 -0400, John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> It looks like the scheduler tunables have been removed from 2.6
>> somewhere before 2.6.17. 
> 
> Which tunables are you referring to?
> 
> 

http://kerneltrap.org/node/525

The relevant code changes in sysctl.h and sched.c seem to be undone.  Of
course I'm assuming my distribution didn't just add a side patch in at
the time when I noticed these existed so long ago.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRQ1nhAs1xW0HCTEFAQJ9ow/9FJGsdk/7QT6oQxZpvHgyu7x25VBN94EG
AVEP8LUGY8YHj51wRlJiBz03gBAukoW6ZHFjgSKhria/4L4pA1XluOvU9zA/1epk
MXi9m84NiL7Jxf1tWadD/APuXGpGoyhDWbMC5CDZWv8Pm6ypQz4hyEQfxHKJSVke
v09RnO1OHneJQgmOEC8zBnP7900uu+xFcoNjY+fgUi58QS18vWrySTrnrRlfTXSC
8SULfavvsnAL5ErSzC9pyhCREl8XKsyX8LrbK7Je8hRnuhwnNdFN2TZSIKqG+kLQ
aMYj+Dadqw4QivBjipgwSQ7rTcawBPZzkR6qIeITZ6SyNg10PGn9Bj+D1eiFpCU6
0tUEfdhefWToXMMTYFyGr8yZP13UzPg6ND1NWwTeuEflObTlkwXEc2zIkn0EzjEK
ETxQRq7E7v2L+eGxnddf6kPQl69BtrCfwkpapJ6YK8dV0eeRLsncvDd2XYr4/000
aUsoh3dTqnV0s2TW4rnzRTmgTE0/U5tNsFAoVeYRKxfTGzdTE2dRrGIXyGjW+C2D
YBLEzdkq20UMVfjGLSw0vHdr14wjnCFQwM9kK1RSgOKi31J/AHfI0bPIL4Em1a87
8KLOV5Fk/Ri+s2+sJOSf6WE6TAkrjS+CnYm40FuROvzyKCCmNj7gMl4DDtxzvjUi
oD/Li5Yn5Bw=
=qLt2
-----END PGP SIGNATURE-----
