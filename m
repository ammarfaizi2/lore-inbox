Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313850AbSDJVaL>; Wed, 10 Apr 2002 17:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSDJVaK>; Wed, 10 Apr 2002 17:30:10 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:42982 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S313850AbSDJVaJ>; Wed, 10 Apr 2002 17:30:09 -0400
To: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
Cc: "James Simmons" <jsimmons@transvirtual.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
In-Reply-To: <A015F722AB845E4B8458CBABDFFE63420FE3D3@mail0.myrio.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Wed, 10 Apr 2002 23:28:56 +0200
Message-ID: <878z7vxmxz.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Torrey Hoffman" <Torrey.Hoffman@myrio.com> writes:

> well, technically that's true.  However they would not be able to link 
> it into the proprietary operating system and then distribute it without 
> violating the GPL.

Are you sure?  Here's a quote from the GPL:

| However, as a special exception, the source code distributed need not
| include anything that is normally distributed (in either source or
| binary form) with the major components (compiler, kernel, and so on)
| of the operating system on which the executable runs, unless that
| component itself accompanies the executable.

Modules for proprietary kernels seem to be okay, don't they?

> - or, implement it in _user-space_ as an entirely GPL'ed application.

I don't see the user space requirement.

> Finally, that second option could be even more difficult... I hear 
> MS has recently changed the terms of their C run-time-library license
> to forbid use by GPLed code.

This is extremely unlikely, as Microsoft is selling its own version of
an operation system with GNU components. ;-)

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
