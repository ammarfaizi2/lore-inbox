Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130697AbRAEQLt>; Fri, 5 Jan 2001 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130634AbRAEQLi>; Fri, 5 Jan 2001 11:11:38 -0500
Received: from queen.bee.lk ([203.143.12.182]:1285 "EHLO bee.lk")
	by vger.kernel.org with ESMTP id <S130127AbRAEQL0>;
	Fri, 5 Jan 2001 11:11:26 -0500
Date: Fri, 5 Jan 2001 22:10:02 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@bee.lk>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Anuradha Ratnaweera <anuradha@gnu.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.0 is available
In-Reply-To: <20010105113104.L888@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0101052200380.2574-100000@bee.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Erik Mouw wrote:

> On Fri, Jan 05, 2001 at 12:48:04PM +0600, Anuradha Ratnaweera wrote:
> > Why not DEB?
> 
> Because Keith doesn't have a Debian system? He just provides the rpms
> as a service, he doesn't have to do that.

Of cource he doesn't have to do that. It is just nice to have all of them.

> Install the "alien" package on your machine and you will be able to
> convert between rpm and deb.

Alien does an excellent job in converting some packages, but for others
including pre/post installation scripts (with -c) conversion is not
perfect. The reason is not a problem with alien, but most RPMs assumes
(correcly) that the target system is `RedHat like'.

The reason I was looking for the debian package was to test 2.4 on a
"stable" debian system. If I install modutils from source, package
management system (dpkg/apt) will not know its existence.


Anuradha

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
