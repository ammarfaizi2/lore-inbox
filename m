Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHXHlh>; Sat, 24 Aug 2002 03:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHXHlg>; Sat, 24 Aug 2002 03:41:36 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:19357 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315374AbSHXHlg>; Sat, 24 Aug 2002 03:41:36 -0400
Date: Sat, 24 Aug 2002 01:45:47 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: "Daniel I. Applebaum" <kernel@danapple.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31 build failure
In-Reply-To: <Pine.LNX.4.44.0208231914080.22497-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208240143430.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Aug 2002, Kai Germaschewski wrote:
> gcc -v 
> rpm -qa | grep gcc

Can be very confusing:

[thunder@bluemoon ~] (0) gcc -v
Reading specs from /usr/lib/gcc-lib/i586-pc-linux-gnu/3.1.1/specs
Configured with: ./configure --prefix=/usr --exec-prefix=/usr --with-gnu-ld --with-gnu-as --with-elf --enable-checking=misc,tree,gc,gcac --enable-c-mbchar --enable-threads --enable-shared --with-gc=page
Thread model: posix
gcc version 3.1.1
[thunder@bluemoon ~] (0) rpm -qa | grep "gcc"
gcc-cpp-2.96-0.76mdk
gcc-c++-2.96-0.76mdk
gcc-java-2.96-0.76mdk
gcc-g77-2.96-0.76mdk
libgcc3.0-3.0.4-2mdk
gcc-2.96-0.76mdk
gcc-objc-2.96-0.76mdk
[thunder@bluemoon ~] (0) 

See?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

