Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266461AbRGCHYy>; Tue, 3 Jul 2001 03:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266459AbRGCHYp>; Tue, 3 Jul 2001 03:24:45 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48550 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266460AbRGCHY3>;
	Tue, 3 Jul 2001 03:24:29 -0400
Message-ID: <3B41732A.DD617268@mandrakesoft.com>
Date: Tue, 03 Jul 2001 03:24:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Sean Hunter <sean@dev.sportingbet.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5
In-Reply-To: <2122.994144608@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Tue, 3 Jul 2001 07:50:50 +0100,
> Sean Hunter <sean@dev.sportingbet.com> wrote:
> >Does this defeat my favourite module-related gothcha, that the machine panics
> >if I have (say) a scsi driver builtin to the kernel and the same driver tries
> >to load itself as a module?
> 
> No, but other wip for 2.5 will.

If this occurs in 2.4 it is a bug and should be fixed in 2.4.

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
