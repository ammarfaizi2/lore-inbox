Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154269AbQBWM7s>; Wed, 23 Feb 2000 07:59:48 -0500
Received: by vger.rutgers.edu id <S154359AbQBWMyn>; Wed, 23 Feb 2000 07:54:43 -0500
Received: from mailext02.compaq.com ([207.18.199.33]:39121 "HELO mailext02.compaq.com") by vger.rutgers.edu with SMTP id <S154597AbQBWMrV>; Wed, 23 Feb 2000 07:47:21 -0500
Message-Id: <XFMail.20000223095236.brianw.hall@compaq.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0
In-Reply-To: <3891E2A9.F8488ED@transmeta.com>
Date: Wed, 23 Feb 2000 09:52:36 -0700 (MST)
Reply-To: Brian Hall <brianw.hall@compaq.com>
From: Brian Hall <brianw.hall@compaq.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Subject: Alpha systems available for development (was Re: Intel 810 Random Number Generator)
Cc: linux-kernel@vger.rutgers.edu, Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@suse.cz>, "Theodore Y.Ts'o" <tytso@MIT.EDU>
Sender: owner-linux-kernel@vger.rutgers.edu

Anyone who needs access to an Alpha system for development, please go to:

http://www.testdrive.compaq.com/

On 28-Jan-2000 H. Peter Anvin wrote:
> "Theodore Y. Ts'o" wrote:
>> 
>>    Date:   Fri, 28 Jan 2000 01:43:03 -0800
>>    From: "H. Peter Anvin" <hpa@transmeta.com>
>> 
>>    Why don't we use the TSC on other architectures that have them, e.g.
>>    Alpha?
>> 
>> Because I don't have a (working) Alpha to test it on.  :-)
>> 
>> Send a patch.....  (I'm doing some work on the random driver at the
>> moment, so this would be a good time to fold it in.)
>> 
> 
> Ah, neither have I though (recent enough that I'd use it.)  I have been
> trying to get one from Compaq/DEC for years, but I don't ever seem to
> get to the right person.  (Is anyone at Compaq that could actually do
> something reading this?)
> 
> I'd really like to get fine-granularity timing on Alpha, just like we
> have on Intel.   I understand the Alpha only has a 32-bit TSC, which
> means it has to be periodically sampled to keep track of the high bits.
> 
>       -hpa

--
Brian Hall <brianw.hall@compaq.com>
http://www.bigfoot.com/~brihall
Linux Consultant

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
