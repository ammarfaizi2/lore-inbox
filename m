Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUJKA7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUJKA7u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 20:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUJKA7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 20:59:50 -0400
Received: from nef.ens.fr ([129.199.96.32]:48654 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S268590AbUJKA7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 20:59:46 -0400
Subject: Re: possible GPL violation by Free
From: Eric Rannaud <eric.rannaud@ens.fr>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, okuji@gnu.org
In-Reply-To: <20041010102802.GH19761@alpha.home.local>
References: <200410091958.25251.okuji@gnu.org>
	 <20041010102802.GH19761@alpha.home.local>
Content-Type: text/plain
Date: Mon, 11 Oct 2004 02:59:39 +0200
Message-Id: <1097456379.27877.51.camel@frenchenigma>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Mon, 11 Oct 2004 02:59:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2004-10-10 at 12:28 +0200, Willy Tarreau wrote:
> (at least provide the
> result of an nmap -O). For most end-users, "linux" is the word for "a
> reliable embedded OS with IP support".

Here it is, on a Freebox v1 (the Freebox distributed now is version 3,
but version 1 was still distributed less than one year ago (i.e. under
the 3 years limit in the GPL)).
Disclaimer: this scan output should be taken carefully. Please do not
jump to conclusions.
(IP and MAC hidden)

--------------------------------
Starting nmap 3.70 ( http://www.insecure.org/nmap/ ) at 2004-10-10 20:23
CEST
Initiating SYN Stealth Scan against XX.XX.XX.254 [1660 ports] at 20:23
Discovered open port 22/tcp on XX.XX.XX.254
Discovered open port 199/tcp on XX.XX.XX.254
The SYN Stealth Scan took 5.12s to scan 1660 total ports.
For OSScan assuming that port 22 is open and port 1 is closed and
neither are firewalled
Host XX.XX.XX.254 appears to be up ... good.
Interesting ports on XX.XX.XX.254:
(The 1658 ports scanned but not shown below are in state: closed)
PORT    STATE SERVICE
22/tcp  open  ssh
199/tcp open  smux
MAC Address: 00:07:XX:XX:XX:XX (Freebox SA)
Device type: general purpose
Running: Linux 2.4.X|2.5.X
OS details: Linux 2.4.0 - 2.5.20
OS Fingerprint:
TSeq(Class=RI%gcd=1%SI=40A886%IPID=Z%TS=100HZ)
T1(Resp=Y%DF=Y%W=16A0%ACK=S++%Flags=AS%Ops=MNNTNW)
T2(Resp=N)
T3(Resp=Y%DF=Y%W=16A0%ACK=S++%Flags=AS%Ops=MNNTNW)
T4(Resp=Y%DF=Y%W=0%ACK=O%Flags=R%Ops=)
T5(Resp=Y%DF=Y%W=0%ACK=S++%Flags=AR%Ops=)
T6(Resp=Y%DF=Y%W=0%ACK=O%Flags=R%Ops=)
T7(Resp=Y%DF=Y%W=0%ACK=S++%Flags=AR%Ops=)
PU(Resp=Y%DF=N%TOS=C0%IPLEN=164%RIPTL=148%RID=E%RIPCK=E%UCK=E%ULEN=134%
DAT=E)

Uptime 41.944 days (since Sun Aug 29 21:XX:XX 2004)
TCP Sequence Prediction: Class=random positive increments
                         Difficulty=4237446 (Good luck!)
TCP ISN Seq. Numbers: 99D03998 9A7D22DF 9A644725 9A6FDD72 9A0BEAA0
IPID Sequence Generation: All zeros

Nmap run completed -- 1 IP address (1 host up) scanned in 8.556 seconds
-------------------------------


If I remember correctly my contract, after 36 months, I become the owner
of the freebox. The argument about renting does not seem to hold,
anyway.

I will contact Free to ask for more information.

Best,

     /er.



-- 
Eric Rannaud <eric.rannaud@ens.fr>
http://www.eleves.ens.fr/home/rannaud/

