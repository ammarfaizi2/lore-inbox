Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130478AbQKIM0O>; Thu, 9 Nov 2000 07:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKIM0E>; Thu, 9 Nov 2000 07:26:04 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:60937 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130447AbQKIMZ4>; Thu, 9 Nov 2000 07:25:56 -0500
Message-ID: <3A0A97D0.36C5913B@holly-springs.nc.us>
Date: Thu, 09 Nov 2000 07:25:52 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256992.002FE358.00@d06mta06.portsmouth.uk.ibm.com> <qwwvgtxjslr.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> If we really need a special enterprise tree lets do
> it without module tricks.

Why? I think the IBM GKHI code would be of tremendous value. It would
make the kernel much more flexible, and for users, much more friendly.
No more patch-and-recompile to add a filesystem or whatever. There's no
reason to hamstring their efforts because of the possibility of binary
modules. The GPL allows that, right? So any developer of binary-only
extensions using the GKHI would not be breaking the license agreement, I
don't think. There's lots of binary modules right now -- VMWare, Aureal
sound card drivers, etc.

I understand and agree with your desire for full source for everything,
but I disagree that we should artificially limit people's ability to use
Linux to solve their problems.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
