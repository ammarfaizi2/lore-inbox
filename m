Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVKUOM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVKUOM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKUOM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:12:58 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:36314 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932218AbVKUOM5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:12:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bL2Zm4iq98aEESssalp27iiw/S5Ll0/RYjJH8KK37UCxT9eTQI4JWvGmVNVj/GGMRoc8ff93u89D+NC3fuTsw7aAckFvVrR6B1GiXWaNFMwQFVeF8TYdZ3ngc6dJSGHld5eL9GnMzFIDelC9rc5VzFdq3bi4xoOBjXGVbVkysHM=
Message-ID: <625fc13d0511210612m7c659b9agb7f9a5e1a1de117f@mail.gmail.com>
Date: Mon, 21 Nov 2005 08:12:56 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       scjody@steamballoon.com
In-Reply-To: <20051119012240.GD28175@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051118173930.270902000@press.kroah.org>
	 <20051118173054.GA20860@kroah.com> <20051118173106.GB20860@kroah.com>
	 <625fc13d0511181134lc074b8avcc8db47b8723583@mail.gmail.com>
	 <20051119012240.GD28175@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 18, 2005 at 01:34:51PM -0600, Josh Boyer wrote:
> > On 11/18/05, Greg Kroah-Hartman <gregkh@suse.de> wrote:
> > > From: Jody McIntyre <scjody@steamballoon.com>
> > >
> > > Add tree information to MAINTAINERS file.
> >
> > Missed MTD git tree at:
> >
> > git kernel.org:/pub/scm/linux/kernel/git/tglx/mtd-2.6.git
>
> Care to send a patch for this, and any others that might have been
> missed?

Here's the MTD one.  More later as I find them.

josh

Signed-off-by: Josh Boyer <jwboyer@gmail.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index c5cf7d7..1e84be3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1695,6 +1695,7 @@ P:        David Woodhouse
 M:     dwmw2@infradead.org
 W:     http://www.linux-mtd.infradead.org/
 L:     linux-mtd@lists.infradead.org
+T:     git kernel.org:/pub/scm/linux/kernel/git/tglx/mtd-2.6.git
 S:     Maintained

 MICROTEK X6 SCANNER
