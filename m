Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315149AbSDWKxC>; Tue, 23 Apr 2002 06:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315151AbSDWKxB>; Tue, 23 Apr 2002 06:53:01 -0400
Received: from whiskey.openminds.be ([212.35.126.198]:47551 "EHLO
	whiskey.openminds.be") by vger.kernel.org with ESMTP
	id <S315149AbSDWKxB>; Tue, 23 Apr 2002 06:53:01 -0400
Date: Tue, 23 Apr 2002 12:52:59 +0200
From: Frank Louwers <frank@openminds.be>
To: rpm <rajendra.mishra@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423125259.A1322@openminds.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <200204231054.g3NArPI18473@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-PGP2: 1024R/1A899409  C3 D8 FA D3 E0 0E 40 C5  10 32 83 74 36 F0 E5 95
X-oldGPG: 1024D/3F6A7EDD  D597 566A BDF5 BBFB C308  447A 5E81 1188 3F6A 7EDD
X-GPG: 1024D/E592712F  E857 266C 04BE 0772 B9C4  E798 3D34 D5E5 E592 712F
Organisation: Openminds - http://www.openminds.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 04:23:25PM +0530, rpm wrote:
> check the MAC address  of the two cards cards !  

Mac addresses are different! (In my first setup the addresses only
differed 1 bit (server with 2 nics onboard)), but later I tried with 2
different brand of nics, so they should have been different enough.

> i am also using similar configuration but am not getting any thing like that !

When i disconnect the cable of eth1, and ping it's ip from another
machine and check the arp table for that machine, I get the mac
address for eth0 ...


Frank
