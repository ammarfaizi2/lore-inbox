Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQKIMrS>; Thu, 9 Nov 2000 07:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKIMrJ>; Thu, 9 Nov 2000 07:47:09 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:64777 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129730AbQKIMqz>; Thu, 9 Nov 2000 07:46:55 -0500
Message-ID: <3A0A9CB6.6A22CFE0@holly-springs.nc.us>
Date: Thu, 09 Nov 2000 07:46:46 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256992.002FE358.00@d06mta06.portsmouth.uk.ibm.com> <qwwvgtxjslr.fsf@sap.com> <3A0A97D0.36C5913B@holly-springs.nc.us> <20001109133023.A747@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> And we already refuse to support those kernels - your point being?

Who says you would support theirs? My point is, forks have been made in
the past and are useful for the people that use them, and prevent
"pollution" of the common kernel with hghly specialized modifications.
uCLinux and RTLinux are two examples.

> Making this "commonplace" is a nightmare. Go away with that.

It would be a third major fork (AFAIK), not a first, and not a
nightmare. Are RTLinux and uclinux nightmares? How much do they impact
your life?
 
> I want their solving of their problems not to create problems for me though.

How would it create problems for you? And as a separate question, why
should anyone care if it does? Part of the freedom guaranteed by the GPL
is the ability for anyone to fork a codebase for their own use. And
because it's all GPL code, with thoroughly divirsified copyright
assignment, they will be releasing any mods under GPL as well. The ones
the Linus likes, he can adapt and merge into the common kernel. If he
doesn't like them, he can ignore them.

Incidentally, I hear that a Utah company is going to position an older
Unix kernel with Linux compatibility added and possibly a GNU userspace
as "Enterprise Linux." Would you prefer that, or something actually
based on the Linux codebase?

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
