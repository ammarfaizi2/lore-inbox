Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTDDXPz (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTDDXPz (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:15:55 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:63939 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261449AbTDDXPz (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 18:15:55 -0500
Date: Fri, 4 Apr 2003 18:23:23 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: some serious problems compiling 2.5.66-bk10
Message-ID: <Pine.LNX.4.44.0304041820540.21137-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i wanted to do another test with bk10 to see if i could
track down my keyboard problems.  after having to deselect
a couple graphics drivers as they caused the compile to 
crash, i got a successful build of bzimage and modules.

  but after i typed "make modules_install", the final
depmod generated some 2000 lines of unresolved symbols.
should i have expected this?

rday

