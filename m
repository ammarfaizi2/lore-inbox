Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUAIUvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUAIUvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:51:38 -0500
Received: from simba.math.ucla.edu ([128.97.4.125]:54656 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S264145AbUAIUvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:51:37 -0500
Date: Fri, 9 Jan 2004 12:51:36 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Ian Kent <raven@themaw.net>
Cc: Mike Waychison <Michael.Waychison@sun.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
Message-ID: <Pine.LNX.4.53.0401091249250.9335@simba.math.ucla.edu>
References: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Ian Kent wrote:
> On Thu, 8 Jan 2004, Mike Waychison wrote:
> > This module will have its own new autofs module (hopefully named
> > something other than autofs to avoid confusion/mishaps).  The VFS will

autofs v3 -> autofs.o
autofs v4 -> autofs4.o
May I suggest autofs5.o?  It should still be named "autofs-something",
after all.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
