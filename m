Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281125AbRKENCZ>; Mon, 5 Nov 2001 08:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281127AbRKENCP>; Mon, 5 Nov 2001 08:02:15 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:59313 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S281125AbRKENCN>; Mon, 5 Nov 2001 08:02:13 -0500
Date: Mon, 5 Nov 2001 13:02:12 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Limited RAM - how to save it?
In-Reply-To: <20011105125231.A3783@microdata-pos.de>
Message-ID: <Pine.LNX.4.33.0111051259400.28836-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might like to patch an older Linux than 2.2 :)
dietlibc might help userspace, too.. (though I don't know if you can link
against it)

At 12:52 +0100 Jan-Benedict Glaw wrote:

>I'm working on a 4MB linux system (for a customer) which has quite
>limited resources at all:
>
>	- 4MB RAM
>	- 386 or 486 like processor (9..16 BogoMIPS)
>	- < 100MB HDD
>	- Quite a lot user space running:-(

