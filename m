Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUAHMeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUAHMeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:34:23 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:3558 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264386AbUAHMeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:34:22 -0500
Date: Thu, 8 Jan 2004 20:35:07 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFC8E5B.40203@sun.com>
Message-ID: <Pine.LNX.4.44.0401082026340.354-100000@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Waychison wrote:

>
> This is a good example of why this stuff should probably be merged into
> VFS,  autofs4 has yet to be updated to use this lock.  This comes with
> the decision to a) no longer support it as a module, only built in, or
> b) make vfsmount_lock accessible to modules.

Please don't say it this way.

A new implementation may mean current autofs becomes depricated but
this is a deprecation process, not a slash and burn, and needs to be
managed.

Ian


