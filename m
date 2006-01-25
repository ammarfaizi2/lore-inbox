Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWAYVUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWAYVUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWAYVUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:20:54 -0500
Received: from relay00.pair.com ([209.68.5.9]:24836 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932091AbWAYVUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:20:53 -0500
X-pair-Authenticated: 67.163.102.102
Date: Wed, 25 Jan 2006 15:20:49 -0600 (CST)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2006, linux-os \(Dick Johnson\) wrote:
>
> The original GPL said something about:
> "You may not impose any further restrictions on the recipients'
> exercise of the rights granted herein." (Section 6).
> Then, that __exact__ code was redistributed under Version 2
> which further restricted rights, then additional versions
> which further restricted rights. Now you are planning to
> add additional restrictions? I don't think the present
> so-called license would pass muster in any sane court in
> the United States after the original licensed code was
> plagiarized into a new binding license.
>

Try doing your homework. GPL v1 says:

> Each version is given a distinguishing version number.  If the Program
> specifies a version number of the license which applies to it and "any
> later version", you have the option of following the terms and conditions
> either of that version or of any later version published by the Free
> Software Foundation.  If the Program does not specify a version number
> of the license, you may choose any version ever published by the Free
> Software Foundation.

This means that when the code went GPL v1 -> GPL v2, the transition was 
permissible. Linux v1.0 shipped with the GPL v2. It did not ship with a
separate clause specifying that "You may only use *this* version of the GPL"
as it now does. (I haven't done any research to find out when this clause 
was added, but it was after the transition to v2).

I'm not sure what you're trying to imply about "conversion" or FSF 
"owning" Linux. Choosing to release your software under the GPL, even when 
the GPL is authored by a third party, does not make said third party the 
copyright owner of your work.

If a migration to v3 were to occur, the only potential hairball I see is 
if someone objected on the grounds that they contributed code to a version 
of the kernel Linus had marked as "GPLv2 Only". IANAL.

- Chase
