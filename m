Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSDNJuC>; Sun, 14 Apr 2002 05:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311919AbSDNJuB>; Sun, 14 Apr 2002 05:50:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:15108 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311917AbSDNJuB>;
	Sun, 14 Apr 2002 05:50:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: spyro@armlinux.org, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG* 
In-Reply-To: Your message of "Sun, 14 Apr 2002 10:26:32 +0100."
             <20020414102632.A30379@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 19:49:44 +1000
Message-ID: <1959.1018777784@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002 10:26:32 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sun, Apr 14, 2002 at 10:11:48AM +1000, Keith Owens wrote:
>> Any particular reason for not using ksymoops?  If it does not work on
>> arm, I can get rid of all the arm code ;).
>
>It does work on ARM.  I use it, and we've had a few posts using it.
>However, since it took several _months_ for the ksymoops version with
>the fixed regexps for ARM to come out, I don't really think you're
>justified in the above comments.

You missed the smiley.

I must admit that ksymoops tends to be the poor relation, it is my
lowest priority out of ia64, kdb, kbuild, modutils and ksymoops.  Now
if I could just get kbuild 2.5 and kdb into the kernel, I would have
more time for the other projects :-)>

