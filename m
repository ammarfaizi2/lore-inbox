Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbTCICIl>; Sat, 8 Mar 2003 21:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbTCICIl>; Sat, 8 Mar 2003 21:08:41 -0500
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:53673 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S262357AbTCICIj>; Sat, 8 Mar 2003 21:08:39 -0500
Date: Sat, 8 Mar 2003 21:19:12 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       ML-uml-user <User-mode-linux-user@lists.sourceforge.net>
cc: William Stearns <wstearns@pobox.com>
Subject: 2.5.64-bk3 UML kernel available
Message-ID: <Pine.LNX.4.44.0303082103060.3395-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	For those interested in trying out a 2.5 kernel but are a little
nervous about using it on a production system, I have a precompiled UML
kernel at http://www.stearns.org/uml/linux-2.5.64-bk3-63um1-3.bz2 .  Pull
down, decompress, and use with a uml root filesystem (see
http://user-mode-linux.sourceforge.net).  Options used are in
http://www.stearns.org/uml/config-2.5.64-bk3-63um1-3 , System.map at
http://www.stearns.org/uml/System.map-2.5.64-bk3-63um1-3 .
	As with any development kernel, please remember that this may very 
well corrupt data.  Please make a backup of your UML root filesystem 
before using.  The kernel _appears_ to work - no more guarantees than 
that.  :-)
	(For those interested in compiling it themselves, Jeff's
2.5.63-um1 patch plus
http://www.stearns.org/uml/linux-2.5.64-bk3-63um1-initcall.patch is all
that appears to be needed)
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Do what you love, and love what you do, and you will never work
another day in your life."
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

