Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265611AbRF1Jxz>; Thu, 28 Jun 2001 05:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265614AbRF1Jxo>; Thu, 28 Jun 2001 05:53:44 -0400
Received: from core.devicen.de ([62.159.186.206]:33294 "EHLO core.devicen.de")
	by vger.kernel.org with ESMTP id <S265611AbRF1Jxb>;
	Thu, 28 Jun 2001 05:53:31 -0400
Date: Thu, 28 Jun 2001 11:52:28 +0200
From: Oliver Teuber <teuber@core.devicen.de>
To: Adam <adam@eax.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.x series and mm
Message-ID: <20010628115103.C12685@core.devicen.de>
In-Reply-To: <Pine.LNX.4.33.0106271008010.16671-100000@eax.student.umd.edu> <E15FI9n-0005Qz-00@the-village.bc.nu> <20010628083303.A27891@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010628083303.A27891@dev.sportingbet.com>; from sean@dev.sportingbet.com on Thu, Jun 28, 2001 at 08:33:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

> > a)	Add more RAM - that is the real optimal approach
> > b)	Make the processes smaller (eg switch to thttpd from www.acme.com)
> > c)	Speed up the I/O throughput relative to CPU speed
> > 	- eg the 2.2 IDE UDMA patches
> d)	Reduce the number of Apache processes so they fit nicely in RAM
e) Set KeepAlive to Off

yours, oliver teuber 

