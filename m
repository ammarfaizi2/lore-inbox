Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTAMQXc>; Mon, 13 Jan 2003 11:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTAMQXc>; Mon, 13 Jan 2003 11:23:32 -0500
Received: from almesberger.net ([63.105.73.239]:61960 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267503AbTAMQXb>; Mon, 13 Jan 2003 11:23:31 -0500
Date: Mon, 13 Jan 2003 13:32:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why the new config process is a *big* step backwards
Message-ID: <20030113133200.D6866@almesberger.net>
References: <Pine.LNX.4.44.0301130743100.25468-100000@dell> <20030113153212.GB12500@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113153212.GB12500@louise.pinerecords.com>; from szepe@pinerecords.com on Mon, Jan 13, 2003 at 04:32:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> If you need a nifty graphical frontend right away, I suggest you
> go ahead and write the first off-tree xconfig.

... and as a starting point, perhaps something that looks like
ftp://icaftp.epfl.ch/pub/linux/local/scend/scend-0.5.tar.gz
(when compiling, change "msg" to "dummy" where it complains)
might not be all that bad.

(Okay, it's text-based, doesn't know about modules, uses its own
language, and comes with an example for a kernel as recent as
1.1.80 :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
