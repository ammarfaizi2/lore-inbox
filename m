Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKDSPl>; Sat, 4 Nov 2000 13:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKDSPb>; Sat, 4 Nov 2000 13:15:31 -0500
Received: from 125-68-127-216.ip.sirius.com ([216.127.68.125]:47109 "EHLO
	gateway.geolog.com") by vger.kernel.org with ESMTP
	id <S129044AbQKDSPP>; Sat, 4 Nov 2000 13:15:15 -0500
Date: Sat, 4 Nov 2000 10:14:53 -0800
From: John Shifflett <john@geolog.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pppd and 2.4.0pre10
Message-ID: <20001104101453.A79@main.geolog.com>
In-Reply-To: <Pine.LNX.4.21.0011041757570.32560-100000@tahallah.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2us
In-Reply-To: <Pine.LNX.4.21.0011041757570.32560-100000@tahallah.clara.co.uk>
X-Operating-System: Linux 2.4.0-test10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 05:59:21PM +0000, Alex Buell wrote:

> I'm getting this problem each time I start pppd whenever I dial up if the
> ppp modules have been unloaded from memory. The odd thing is that I can
> repeat 'ppp-on' and it will work fine!

   Another odd thing is that I have the same problem, but with ppp
   compiled into the kernel (present in /proc/devices). There doesn't
   seem to be any way to fool it into working in my case. 'pppd' version
   is 2.4.0.

      John Shifflett    john@geolog.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
