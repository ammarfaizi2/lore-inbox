Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbTCGTKn>; Fri, 7 Mar 2003 14:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTCGTKm>; Fri, 7 Mar 2003 14:10:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261730AbTCGTKk>;
	Fri, 7 Mar 2003 14:10:40 -0500
Date: Fri, 7 Mar 2003 19:21:15 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030307192115.H3865@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As such, and since Peter is the main author, I don't see your argument,
> Roman.

klibc is losing at least some potential developers by virtue of its
licence.  I'm not willing to release code under the BSD licence and would
prefer full GPL.  I'm willing to compromise on LGPL, but Peter isn't.
He came out with some nonsense about wanting proprietary apps in early
userspace (which seems like a ludicrous thing to _favour_, but...) which
LGPL doesn't prevent you from doing, even with a non-shared library.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
