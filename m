Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279999AbRJ3QZp>; Tue, 30 Oct 2001 11:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279989AbRJ3QZf>; Tue, 30 Oct 2001 11:25:35 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:39592 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S280002AbRJ3QZZ>; Tue, 30 Oct 2001 11:25:25 -0500
Date: Tue, 30 Oct 2001 16:25:45 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Neale Banks <neale@lowendale.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.05.10110301839250.23080-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.33.0110301623171.8732-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:46 +1100 Neale Banks wrote:

>> It wraps at 496 days. The drivers are aware of it and dont crash the box
>
>You mean there was a time when uptime>496days would crash a system?

Amusingly I had to fight at an old workplace of mine to upgrade to a 2.1
kernel. I built 2.1.103 with a snapshot of a compiler which eventually
became egcs-1.0.3 (IIRC) which hit that bug (long after I'd left the job).

I believe the fix went in at 2.1.106 or so :-/

