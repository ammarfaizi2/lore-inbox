Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRJ1N2n>; Sun, 28 Oct 2001 08:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278375AbRJ1N2e>; Sun, 28 Oct 2001 08:28:34 -0500
Received: from cogito.cam.org ([198.168.100.2]:44548 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S278364AbRJ1N20>;
	Sun, 28 Oct 2001 08:28:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Dan <dphoenix@bravenet.com>
Subject: Re: [reiserfs-list] 2.4.14-pre3 and umount
Date: Sun, 28 Oct 2001 08:24:22 -0500
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
In-Reply-To: <20011027222520.U97690-100000@gandalf.bravenet.com>
In-Reply-To: <20011027222520.U97690-100000@gandalf.bravenet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011028132422.F180F11716@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 28, 2001 01:25 am, Dan wrote:
> might have a process accessing /back?
> lsof|grep back

Forgot about lsof...  it found a gzip hiding.  I had tried
ps -eaf | grep back but found nothing.  

I am glad this turn out to be a non bug - pre3 seems to be
a quite nice kernel here.

Thanks
Ed Tomlinson
