Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313533AbSDJSqZ>; Wed, 10 Apr 2002 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313535AbSDJSqY>; Wed, 10 Apr 2002 14:46:24 -0400
Received: from [209.249.147.146] ([209.249.147.146]:17412 "EHLO
	addr-mx02.addr.com") by vger.kernel.org with ESMTP
	id <S313533AbSDJSqW>; Wed, 10 Apr 2002 14:46:22 -0400
Date: Wed, 10 Apr 2002 14:45:08 -0400
From: Daniel Gryniewicz <dang@fprintf.net>
To: "Nicholas Berry" <nikberry@med.umich.edu>
Cc: aab@cichlid.com, linux-kernel@vger.kernel.org
Subject: Re: Tyan S2462 reboot problems
Message-Id: <20020410144508.48a1a482.dang@fprintf.net>
In-Reply-To: <scb42e4b.034@mail-01.med.umich.edu>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hercules 4500 (Kyro II).  I run the Vesa drivers, as I don't run any of the
distro's that have beta drivers, and I do have video corruption occasionally,
but not very often (and never in Windows).

Daniel

On Wed, 10 Apr 2002 12:21:03 -0400
"Nicholas Berry" <nikberry@med.umich.edu> wrote:

> What display adapter are you using? BIOS's earlier than 1.04 screwed up
royally with ATI Radeon 8500/7500 cards - actually, so does 1.04, but not as
much. I've also noticed that Radeon + Adaptec 39160 corrupts video where
without the Adaptec it doesn't. Strange.> 
> Nik
> 
> (This is on the 2460, not 2462)
> 
> >>> Daniel Gryniewicz <dang@fprintf.net> 04/09/02 04:14PM >>>
> > Hi.
> 
> > No, I doubt this has anything to do with Linux.   I have a S2460 (which
his> > corrected post says he has), which does not power down under linux, and
> > *never* warm boots cleanly.  It does power down under windows, so I assume
> > ACPI powerdown works and APM does not.  I have gone under the assumption
that> > a BIOS upgrade will fix this, but that involves putting a floppy into
the box,> > so I haven't done it yet.  The warm boot problems consist of
either a hang> > after POST (but before bootloader, OS irrelevent), or really
bad video> > corruption.  I don't know if it boot with the video corruption,
I've never let> > it try.
> 
> > Daniel


--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

