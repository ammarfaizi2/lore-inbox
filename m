Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130632AbQLHRXO>; Fri, 8 Dec 2000 12:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131862AbQLHRXE>; Fri, 8 Dec 2000 12:23:04 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130632AbQLHRWt>; Fri, 8 Dec 2000 12:22:49 -0500
Date: Fri, 8 Dec 2000 11:52:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: richardj_moore@uk.ibm.com
cc: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <802569AF.005B3839.00@d06mta06.portsmouth.uk.ibm.com>
Message-ID: <Pine.LNX.3.95.1001208115059.1500B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000 richardj_moore@uk.ibm.com wrote:

> 
> 
> Actually what you are pointing out here is the differing needs for
> differing uses. Real-time, embedded systems etc have different requirements
> or at lest different priorities to enterprise usage. I'm coming from the
> enterprise server angle - the Linux/390 type of use and high end IA32
> Server.
> 
> I'll certainly add the double-fault hander to my list of RAS stuff. I'm not
> so convinced about NMI being a task gate.
> 
> Richard
> 
> 
[Snipped...]

As I said, if you need some help I'll gladly try.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
