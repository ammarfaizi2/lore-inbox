Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315826AbSEEHKJ>; Sun, 5 May 2002 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315827AbSEEHKI>; Sun, 5 May 2002 03:10:08 -0400
Received: from oss.SGI.COM ([128.167.58.27]:40881 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S315826AbSEEHKH>;
	Sun, 5 May 2002 03:10:07 -0400
Date: Sun, 5 May 2002 00:09:56 -0700
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Malcolm Mallardi <magamo@ranka.2y.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7 MIPS compile errors.
Message-ID: <20020505000956.A24328@dea.linux-mips.net>
In-Reply-To: <20020424145825.A21701@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 02:58:25PM -0400, Malcolm Mallardi wrote:

> The MIPS box (an SGI Indy) has been having problems compiling kernels
> since I first put Linux on it I've never had a kernel complete the
> basic image compile (make vmlinux)  between 2.4.16-2.4.18 there were
> problems compiling one of the keyboard drivers, 2.4.19-pre5 had the two
> problems I'm about to describe, as does 2.4.19-pre7.  2.4.19-pre6
> wouldn't even attempt to compile.

The stock kernel doesn't build for MIPS nor has all the latest fixes.
Get the latest 2.4 kernel from the cvs archive on oss.sgi.com, branch
linux_2_4, see also the section about anon cvs in
http://oss.sgi.com/mips/mips-howto.html.

  Ralf
