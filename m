Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbSLEEuZ>; Wed, 4 Dec 2002 23:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSLEEuZ>; Wed, 4 Dec 2002 23:50:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267222AbSLEEuY>;
	Wed, 4 Dec 2002 23:50:24 -0500
Date: Wed, 4 Dec 2002 22:41:10 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Parallel build broken in latest BK
In-Reply-To: <20021205044913.GA30035@gtf.org>
Message-ID: <Pine.LNX.4.33.0212042240520.924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Try the GNU-and-improved:
> 
> 	make -j4
> 
> I just tried that and it works fine.
> 
> I think MAKE= is a remnant of the old kbuild.  Shouldn't be needed
> anymore since the build doesn't descend into directories the way it used
> to.
> 
> Also, just plain "make" is preferred now, too :)
> It builds bzImage and modules both.

Ahhh. Very nice. 

Thanks,

	-pat

