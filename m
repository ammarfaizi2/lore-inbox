Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbTCGTsj>; Fri, 7 Mar 2003 14:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbTCGTsj>; Fri, 7 Mar 2003 14:48:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46510
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261751AbTCGTsi>; Fri, 7 Mar 2003 14:48:38 -0500
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307192115.H3865@parcelfarce.linux.theplanet.co.uk>
References: <20030307192115.H3865@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047071096.20794.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 21:04:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 19:21, Matthew Wilcox wrote:
> prefer full GPL.  I'm willing to compromise on LGPL, but Peter isn't.
> He came out with some nonsense about wanting proprietary apps in early
> userspace (which seems like a ludicrous thing to _favour_, but...) which
> LGPL doesn't prevent you from doing, even with a non-shared library.

Well you can use the BSD klibc code in your LGPL library, Peter just can't
get the changes back ;)

