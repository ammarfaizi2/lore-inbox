Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbRBDXrC>; Sun, 4 Feb 2001 18:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132365AbRBDXqy>; Sun, 4 Feb 2001 18:46:54 -0500
Received: from mserv1a.vianw.co.uk ([195.102.240.34]:2534 "EHLO
	mserv1a.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S131437AbRBDXqk>; Sun, 4 Feb 2001 18:46:40 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift 
Date: Sun, 04 Feb 2001 23:46:24 +0000
Organization: [private individual]
Message-ID: <g2qr7tg979tgdoohrjih76e5hv6lk1cu58@4ax.com>
In-Reply-To: <Pine.LNX.4.21.0102040756120.5276-100000@fd0man.accesstoledo.com> <200102041531.f14FVZr21669@habitrail.home.fools-errant.com>
In-Reply-To: <200102041531.f14FVZr21669@habitrail.home.fools-errant.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Feb 2001 10:31:35 -0500, you wrote:

>Technical explanations aside, some sort of clock drift exists in all 
>computers. My experience with Sun hardware, for instance, was that the 
>hardware and software clocks rarely agreed.
>
>You should set up your machines to use some sort of time synchronization 
>software, such as ntp or rdate. When I didn't have a 24/7 net presence, I had 
>my ppp script run ntpdate when the connection was complete.
>
>See http://www.eecis.udel.edu/~ntp/
>

If you don't have 24/7 net presence then chrony does a nice job of
sorting out your clock.


http://www.rrbcurnow.freeuk.com/freeuk.com/r/r/b/rrbcurnow/webspace/chrony




Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
