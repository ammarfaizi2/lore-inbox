Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTLBTsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTLBTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:48:18 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:64668 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264335AbTLBTsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:48:17 -0500
Date: Tue, 2 Dec 2003 20:48:37 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocglinux@yahoo.es>
To: "Stefan J. Betz" <stefan_betz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/linux/version.h
Message-Id: <20031202204837.1b666f51.diegocglinux@yahoo.es>
In-Reply-To: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
References: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 2 Dec 2003 19:35:22 +0100 "Stefan J. Betz" <stefan_betz@gmx.net> escribió:

> Hello People,
> 
> i have found some wrong thing in include/linux/version.h

include/linux/version.h isn't provided in the kernel tarball. It is
created when you build something. Ej: do a "make distclean", then:

diego@estel:~/kernel/unsta$ cat include/linux/version.h 
cat: include/linux/version.h: No such file or directory
