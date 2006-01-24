Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWAXONK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWAXONK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAXONK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:13:10 -0500
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:3784 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932104AbWAXONJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:13:09 -0500
X-IronPort-AV: i="4.01,214,1136178000"; 
   d="scan'208"; a="681993725:sNHT15654122"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.13811.386903.438419@smtp.charter.net>
Date: Tue, 24 Jan 2006 09:13:07 -0500
From: "John Stoffel" <john@stoffel.org>
To: Andy Spiegl <kernelbug.Andy@spiegl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
In-Reply-To: <20060124121542.GB13646@spiegl.de>
References: <20060124121542.GB13646@spiegl.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andy>  - on my Intel Pentium 4 CPU 2.60GHz CPU I upgraded to kernel
Andy>  2.6.15 (from kernel.org, compiled with Debian's make-kpkg),
Andy>  .config attached

Andy>  - I own an ATI Radeon 9000 card and am using the closed source
Andy>  driver fglrx 8.20.8-i386 together with XFree86 (Debian
Andy>  4.3.0.dfsg.1-14sarge1) to be able to use OpenGL.

Sorry, but unless you can reproduce this error WITHOUT the closed
source module, we cannot help you at all.  Talk to ATI, it's their
code doing something wrong.

John
