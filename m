Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTARLIL>; Sat, 18 Jan 2003 06:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTARLIL>; Sat, 18 Jan 2003 06:08:11 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:16033 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S264631AbTARLIK>;
	Sat, 18 Jan 2003 06:08:10 -0500
Date: Sat, 18 Jan 2003 12:20:36 +0100
From: Mattia Dongili <dongili@supereva.it>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 doesn't boot - hangs after 'Uncompressing the kernel'
Message-Id: <20030118122036.24c9958b.dongili@supereva.it>
In-Reply-To: <20030118100955.GB1138@middle.of.nowhere>
References: <20030118081408.GA1163@middle.of.nowhere>
	<20030118093743.GB1483@mars.ravnborg.org>
	<20030118100955.GB1138@middle.of.nowhere>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 18 Jan 2003 11:09:55 +0100
Jurriaan <thunder7@xs4all.nl> wrote:
[...]
> > People have problems after recent changes in vmlinux.lds.
> > 
> > Try apply the vmlinux patch from Andrew's set of patches:
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm2/
> > 
> > Usually report is an oops, but that may be UP only.
> > 
> No change, both 2.5.59-mm2 and 2.5.59 + the mm2 vmlinux patch hang just
> in the same way.
> 
> This is on a Debian/Unstable system, btw.

I have the same problem here, I tried 2.5.59 + vmlinux.patch. I'm Debian/testing.
BTW, 2.5.58 didn't go further too.

--
mattia

