Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbRB1CAR>; Tue, 27 Feb 2001 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129973AbRB1CAI>; Tue, 27 Feb 2001 21:00:08 -0500
Received: from cts2161208021.cts.com ([216.120.80.21]:11504 "EHLO NICK2.")
	by vger.kernel.org with ESMTP id <S129797AbRB1CAF>;
	Tue, 27 Feb 2001 21:00:05 -0500
Date: Tue, 27 Feb 2001 18:00:02 -0800
From: Nick Pasich <npasich@crash.cts.com>
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Error running menuconfig
Message-ID: <20010227180002.A19242@NICK2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 I received this error running "make menuconfig" after applying
 patch-2.4.2-ac6.bz2 to linux-2.4.2 ...........................

                     ----( Nick Pasich )----

 ************************************************************************
 ************************************************************************

 Menuconfig has encountered a possible error in one of the kernel's
 configuration files and is unable to continue.  Here is the error
 report:

  Q> scripts/Menuconfig: MCmenu0: command not found

  Please report this to the maintainer <mec@shout.net>.  You may also
  send a problem report to <linux-kernel@vger.kernel.org>.

  Please indicate the kernel version you are trying to configure and
  which menu you were trying to enter when this error occurred.

  make: *** [menuconfig] Error 1

 ************************************************************************
 ************************************************************************

