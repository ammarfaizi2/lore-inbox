Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282993AbRLMBsZ>; Wed, 12 Dec 2001 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLMBsP>; Wed, 12 Dec 2001 20:48:15 -0500
Received: from [216.151.155.121] ([216.151.155.121]:3346 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S282993AbRLMBsF>; Wed, 12 Dec 2001 20:48:05 -0500
To: Alon Altman <alon@vipe.technion.ac.il>
Cc: J Sloan <jjs@lexus.com>, Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where does 'vmlinuz' come from?
In-Reply-To: <Pine.LNX.4.33L2.0112130202480.21624-100000@alon1.dhs.org>
From: Doug McNaught <doug@wireboard.com>
Date: 12 Dec 2001 20:47:51 -0500
In-Reply-To: Alon Altman's message of "Thu, 13 Dec 2001 02:03:35 +0200 (IST)"
Message-ID: <m3d71jsxfc.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Altman <alon@vipe.technion.ac.il> writes:

> On Wed, 12 Dec 2001, J Sloan wrote:
> 
> > Pozsar Balazs wrote:
> >
> > > This is not a bugreport, but a simple question: :)
> > > where does the term vmlinuz come from?
> >
> > compressed vmlinux = vmlinux.z -> vmlinuz?
> 
>   Yes, but I think he wanted to know where 'vmlinux' came from... what does
> the "vm" stand for? Virtual Memory?

Yes.  The kernel binary on ancient AT&T versions was called 'unix'.
When Berkeley wrote a new kernel with virtual memory, they called it
'vmunix'.  So naturally the Linux kernel is 'vmlinux' and the
compressed version is 'vmlinuz' as above.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
