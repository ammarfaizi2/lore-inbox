Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268357AbTBSLPF>; Wed, 19 Feb 2003 06:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268358AbTBSLPF>; Wed, 19 Feb 2003 06:15:05 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:8950 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268357AbTBSLPE>; Wed, 19 Feb 2003 06:15:04 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Hirling Endre <endre@interware.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
Date: Wed, 19 Feb 2003 12:24:57 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <3E536237.8010502@blue-labs.org> <1045653449.26291.39.camel@dusk.interware.hu>
In-Reply-To: <1045653449.26291.39.camel@dusk.interware.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302191224.57667.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 February 2003 12:17, Hirling Endre wrote:
> On Wed, 2003-02-19 at 11:53, David Ford wrote:
> > 2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm
> > careful and do very little in X, it seems to stay up for a few days.  If
> > I do any sort of fast graphics or sound, etc, it'll die very quickly.
> > 'tis an instant death with no OOPS, nothing at all on screen, nothing on
> > serial console.
>
> You're lucky, for me 2.5.60+ freezes right after "uncompressing kernel".
> Tried with and without ACPI, with and without 'noapic', with APIC
> enabled and disabled in the BIOS.
>
> 2.5.59 is just unstable.
>
> (msi kt4 ultra MB, athlon xp 2200+, gcc 3.2.2)
>
> I'll try a minimal 2.5.62 now.

Endre, check out this thread:

Re: 2.5.62 fails to boot, Uncompressing... and then nothing

Duncan.
