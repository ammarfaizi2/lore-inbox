Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUDPJIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 05:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUDPJIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 05:08:15 -0400
Received: from mail.shareable.org ([81.29.64.88]:34722 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262770AbUDPJIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 05:08:14 -0400
Date: Fri, 16 Apr 2004 10:07:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Capitals in kernel directory-names
Message-ID: <20040416090732.GD22226@mail.shareable.org>
References: <Pine.LNX.4.33.0404161029380.1869-100000@pcgl.dsa-ac.de> <Pine.GSO.4.58.0404161052220.20787@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0404161052220.20787@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> Files and directories that start with capitals show up first when using `ls',
> that's why people use e.g. README, INSTALL, and Documentation.

They used to.  Maybe on your system they still do.  (Hint: $LANG).

  [jamie@dual dual-2.6.5]$ ls
  arch     Documentation  init    MAINTAINERS  README          sound
  COPYING  drivers        ipc     Makefile     REPORTING-BUGS  System.map
  CREDITS  fs             kernel  mm           scripts         usr
  crypto   include        lib     net          security        vmlinux

-- Jamie
