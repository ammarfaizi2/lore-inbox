Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSALQzS>; Sat, 12 Jan 2002 11:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSALQzJ>; Sat, 12 Jan 2002 11:55:09 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:33029 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287158AbSALQyy>;
	Sat, 12 Jan 2002 11:54:54 -0500
Date: Sat, 12 Jan 2002 09:52:09 -0700
From: yodaiken@fsmlabs.com
To: jogi@planetzork.ping.de
Cc: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112095209.A5735@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020112160714.A10847@planetzork.spacenet>; from jogi@planetzork.ping.de on Sat, Jan 12, 2002 at 04:07:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> I did my usual compile testings (untar kernel archive, apply patches,
> make -j<value> ...

If I understand your test, 
you are testing different loads - you are compiling kernels that may differ
in size and makefile organization, not to mention different layout on the
file system and disk.

What happens when you do the same test, compiling one kernel under multiple
different kernels?

