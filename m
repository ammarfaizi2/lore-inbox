Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131034AbQLRI7k>; Mon, 18 Dec 2000 03:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbQLRI7b>; Mon, 18 Dec 2000 03:59:31 -0500
Received: from site3.talontech.com ([208.179.68.88]:38754 "EHLO
	site3.talontech.com") by vger.kernel.org with ESMTP
	id <S131034AbQLRI7Q>; Mon, 18 Dec 2000 03:59:16 -0500
Message-ID: <3A3DCA87.4425FB1@linux.com>
Date: Mon, 18 Dec 2000 00:27:52 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.3.96.1001215205918.13941A-100000@artax.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------3465952BE09FAE7AA68B9620"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3465952BE09FAE7AA68B9620
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mikulas Patocka wrote:

> > Oh, and try to eat atomic memory by ping -f kORBit-ized box.
>
> When linux is out of atomic memory, it will die anyway.

Only if you subscribe to the "we don't need to handle exceptions or check return
values" programmers guild...i.e. lazy error prone coders.

I tend to run out of memory a lot and Linux is handling things pretty well.  I
must say, I haven't had a memory pressure kill my machine in oh...six months?
...when the new VM went in and there were bugs to be worked out.

Programmers who write like this..or should I say "scripters"...are the bane of
good clean code.  They're the ones that write bloated apps, the ones where their
cgi leaves 4,000,000 junk cookies behind...in one directory, that chews up 40
megs of memory in their .pl shopping cart so a customer can order one widget...

</rant>

-d


--------------3465952BE09FAE7AA68B9620
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------3465952BE09FAE7AA68B9620--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
