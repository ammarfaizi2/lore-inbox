Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSALRCS>; Sat, 12 Jan 2002 12:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287196AbSALRCJ>; Sat, 12 Jan 2002 12:02:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42607 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287193AbSALRCB>; Sat, 12 Jan 2002 12:02:01 -0500
Date: Sat, 12 Jan 2002 18:00:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: yodaiken@fsmlabs.com
Cc: jogi@planetzork.ping.de, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112180016.T1482@inspiron.school.suse.de>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020112095209.A5735@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sat, Jan 12, 2002 at 09:52:09AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 09:52:09AM -0700, yodaiken@fsmlabs.com wrote:
> On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> > I did my usual compile testings (untar kernel archive, apply patches,
> > make -j<value> ...
> 
> If I understand your test, 
> you are testing different loads - you are compiling kernels that may differ
> in size and makefile organization, not to mention different layout on the
> file system and disk.

Ouch, I assumed this wasn't the case indeed.

> 
> What happens when you do the same test, compiling one kernel under multiple
> different kernels?

Andrea
