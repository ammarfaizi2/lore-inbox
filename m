Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129325AbQKXPy4>; Fri, 24 Nov 2000 10:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129799AbQKXPyq>; Fri, 24 Nov 2000 10:54:46 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:14323
        "EHLO opus.bloom.county") by vger.kernel.org with ESMTP
        id <S129325AbQKXPyd>; Fri, 24 Nov 2000 10:54:33 -0500
Date: Fri, 24 Nov 2000 08:23:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Gregory Maxwell <greg@linuxpower.cx>, Andries.Brouwer@cwi.nl,
        alan@lxorguk.ukuu.org.uk, bernds@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: gcc 2.95.2 is buggy
Message-ID: <20001124082324.A872@opus.bloom.county>
In-Reply-To: <20001123233454.B27831@xi.linuxpower.cx> <Pine.GSO.4.21.0011232344580.12702-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0011232344580.12702-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Nov 23, 2000 at 11:47:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 11:47:04PM -0500, Alexander Viro wrote:
> 
> 
> On Thu, 23 Nov 2000, Gregory Maxwell wrote:
> 
> > On Fri, Nov 24, 2000 at 02:57:45AM +0100, Andries.Brouwer@cwi.nl wrote:
> > > but in the meantime there is good confirmation.
> > > This really is a bug in gcc 2.95.2.
> > 
> > ... RedHat's GCC snapshot "2.96" handles this case just fine. 
> 
> Now, if you can isolate the relevant part of the diff between 2.95.2 and
> RH 2.96...

Well, now that there is a testcase, has anyone sent this on to the relevant
gcc lists? (The CCs I saw haven't)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
