Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbSI3Bk7>; Sun, 29 Sep 2002 21:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbSI3Bk7>; Sun, 29 Sep 2002 21:40:59 -0400
Received: from tapu.f00f.org ([66.60.186.129]:5278 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261896AbSI3Bk6>;
	Sun, 29 Sep 2002 21:40:58 -0400
Date: Sun, 29 Sep 2002 18:46:23 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@digeo.com>
Cc: cwhmlist@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: How to capture bootstrap oops?
Message-ID: <20020930014623.GA8740@tapu.f00f.org>
References: <20020929235607.FLPK26495.imf20bis.bellsouth.net@localhost> <3D9794D5.9551485E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9794D5.9551485E@digeo.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:03:33PM -0700, Andrew Morton wrote:

    cwhmlist@bellsouth.net wrote:

    > I need some help, I'm new to this.  I have compliled a 2.5.39
    > kernel for my quad pentium pro system and it is oopsing on
    > bootup.  Unfortunently, it looks like a good portion of the oops
    > scrolls off of the screen.  Since I don't have the ability to
    > hook up a serial terminal, how do I capture this oops so I can
    > report it?

> This might suffice?

[... patch removed ...]

Or try a serial console (if you have access to such a thing).


  --cw
