Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSJITm5>; Wed, 9 Oct 2002 15:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbSJITm5>; Wed, 9 Oct 2002 15:42:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261900AbSJITm4>;
	Wed, 9 Oct 2002 15:42:56 -0400
Date: Wed, 9 Oct 2002 12:47:14 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Peter Samuelson <peter@cadcamlab.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <20021009213937.A12901@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33L2.0210091246320.1001-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Sam Ravnborg wrote:

| On Wed, Oct 09, 2002 at 12:28:44PM -0700, Randy.Dunlap wrote:
| >
| > The kernel would still have the text-mode configurator.
| The way I read the original post by Christoph Hellwig - nope.
| If the kernel config library is outside the kernel then the
| text-mode versions will fail as well.
| Recall that the text-mode version are no longer shell scripts,
| but based on a nice YACC grammar and coded in C.

OK, I missed that.  Sorry.
In that case I might fall into the "ridiculous" camp.  :)

| I do not want to go somewhere for special tools just to configure
| the kernel.
| Basic stuff such as make and gcc is ok to locate elsewhere - in
| specific versions as well. But not some basic kernel only configurator.

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

