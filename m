Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129437AbQKYNHI>; Sat, 25 Nov 2000 08:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYNG7>; Sat, 25 Nov 2000 08:06:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64782 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S131092AbQKYNGx>;
        Sat, 25 Nov 2000 08:06:53 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: ssd@nevets.oau.org (Steven S. Dick), linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 (pre1, final) OOPS during boot/modprobe 
In-Reply-To: Your message of "Sat, 25 Nov 2000 12:27:24 -0000."
             <200011251227.eAPCRPe19247@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Nov 2000 23:36:45 +1100
Message-ID: <7012.975155805@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000 12:27:24 +0000 (GMT), 
Russell King <rmk@arm.linux.org.uk> wrote:
>Keith Owens writes:
>> On Sat, 25 Nov 2000 06:10:54 -0500 (EST), 
>> ssd@nevets.oau.org (Steven S. Dick) wrote:
>> >2.4.0-test11-pre1 seems to have broken something.
>> >I have no problems with test10, but test11-pre1 gives three oops
>> >messages during boot.  test11-final gives the exact same OOPS messages...
>> 
>> Which modutils?  And if it is not 2.3.21, upgrade.
>
>Steven probably wants to apply this patch to test11:

Upgrading to modutils 2.3.21 is easier and everybody should do that
anyway to fix the local root exploits.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
