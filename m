Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBCLi4>; Sat, 3 Feb 2001 06:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbRBCLip>; Sat, 3 Feb 2001 06:38:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:40204 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129116AbRBCLij>;
	Sat, 3 Feb 2001 06:38:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels 
In-Reply-To: Your message of "03 Feb 2001 10:09:39 -0000."
             <m28znoulgc.fsf@barnowl.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 22:38:19 +1100
Message-ID: <15031.981200299@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Feb 2001 10:09:39 +0000, 
Graham Murray <graham@barnowl.demon.co.uk> wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>> This has all been thrashed out before.  Read the threads
>> 
>> http://www.mail-archive.com/linux-kernel@vger.rutgers.edu/2000-month-07/msg04096.html
>> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg18256.html
>
>I don't think that these address my question. I was asking about when
>building (upgrading) glibc from source. I believe that the glibc
>headers are "derived" from the kernel against which it is built.

That way everybody builds a different glibc.  Does that strike you as a
good idea?  glibc should be shipped with standard include files.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
