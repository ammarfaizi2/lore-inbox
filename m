Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281439AbRKPQjW>; Fri, 16 Nov 2001 11:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKPQjD>; Fri, 16 Nov 2001 11:39:03 -0500
Received: from ns.caldera.de ([212.34.180.1]:9127 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281458AbRKPQi5>;
	Fri, 16 Nov 2001 11:38:57 -0500
Date: Fri, 16 Nov 2001 17:38:40 +0100
From: Christoph Hellwig <hch@caldera.de>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] mconfig 0.20 available
Message-ID: <20011116173840.A15515@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mconfig release 0.20 is now available.

Mconfig is a tool to configure the linux kernel, similar to
make {menu,x,}config, but written in C and with a proper yacc
parser.

The following changes have been made since the last public
release, 0.18 by Michael Elizabeth Chastain:

* switched to autoconf/automake.
* build 'menu' mode only if curses are available.
* added manpage (VERY simple).
* added specfile for RPM builds.
* help text moved from C source to external file.
* modes 'text' and 'old' implemented.
* verb 'dep_mbool' implemented.
* relaxed error checking - moan in

This release is available as gzip/bzip compressed source tarball at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/mconfig/


	ftp:/ftp.opengfs.org/pub/opengfs/0.0.91/opengfs-0.0.91.tar.gz
	ftp:/ftp.opengfs.org/pub/opengfs/0.0.91/opengfs-0.0.91-1.src.rpm

Please send patches and report bugs to me,

	Christoph

