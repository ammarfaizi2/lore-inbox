Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbTABXQg>; Thu, 2 Jan 2003 18:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbTABXQg>; Thu, 2 Jan 2003 18:16:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267302AbTABXQd>;
	Thu, 2 Jan 2003 18:16:33 -0500
Date: Thu, 2 Jan 2003 15:22:09 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
In-Reply-To: <Pine.LNX.4.44.0301021141210.8604-100000@dell>
Message-ID: <Pine.LNX.4.33L2.0301021520380.22868-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Robert P. J. Day wrote:

| On 2 Jan 2003, Alan Cox wrote:
|
| > On Thu, 2003-01-02 at 14:32, Robert P. J. Day wrote:
| > >
| > >   whatever happened to that funky option from 2.4 --
| > > for kernel .config support, which allegedly buried the
| > > config file inside the kernel itself.  (it never worked --
| > > the alleged extraction script scripts/extract-ikconfig
| > > depended on a program called "binoffset" that didn't
| > > exist in that distribution.)
| >
| > Its never been in the standard 2.4 kernel. The facility has been in the
| > -ac kernel, and was recently submitted for consideration in 2.5
|
| that's odd.  the selection for kernel .config support has been in
| the red hat config menus for at least the last release, as well
| as the extraction script .../scripts/extract-ikconfig.  but this
| never worked due to a missing "binoffset" utility.  i even filed
| a bugzilla on that (bug 65677).

I wasn't aware of this...oh well.
"binoffset.c" is available at
  http://www.osdl.org/archive/rddunlap/patches/

| just curious -- how did that ever end up in the distributed red hat
| kernel if it was never standard?  strange.

Not really.

-- 
~Randy

