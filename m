Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbSKQF1z>; Sun, 17 Nov 2002 00:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267464AbSKQF1z>; Sun, 17 Nov 2002 00:27:55 -0500
Received: from p508B6A0E.dip.t-dialin.net ([80.139.106.14]:36842 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S267463AbSKQF1y>; Sun, 17 Nov 2002 00:27:54 -0500
Date: Sun, 17 Nov 2002 06:34:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dan Kegel <dank@kegel.com>,
       john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021117063413.A18893@linux-mips.org>
References: <3DD5DC77.2010406@pobox.com> <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>; from pat@purdueriots.com on Sat, Nov 16, 2002 at 01:04:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 01:04:35AM -0500, Patrick Finnegan wrote:

> Wouldn't it then seem reasonable to remove things from the kernel that
> have been broken for a long time, and no one seems to care enough to fix?
> I know of at least one driver (IOmega Buz v4l) that seems to have fallen
> into disrepair possibly since before 2.4.0, and as far as I know has not
> been repaired since then.

On a few opportunities when I removed broken features from the MIPS
kernel that was what it took to trigger somebody to fix it.

  Ralf
