Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJUPYN>; Mon, 21 Oct 2002 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJUPYN>; Mon, 21 Oct 2002 11:24:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21731 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261397AbSJUPX0>;
	Mon, 21 Oct 2002 11:23:26 -0400
Date: Mon, 21 Oct 2002 08:21:07 -0700 (PDT)
Message-Id: <20021021.082107.56539790.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rmk@arm.linux.org.uk, hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1035212657.27259.154.camel@irongate.swansea.linux.org.uk>
References: <20021017011957.A9589@flint.arm.linux.org.uk>
	<20021016.171626.112600105.davem@redhat.com>
	<1035212657.27259.154.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 21 Oct 2002 16:04:17 +0100
   
   I disagree here. Its a measurable performance item, and its actually
   going to break less code than for example the last minute scsi and bio
   changes have done
   
That's a good point.

So, if you want to merge the deprecation to Linus when he returns
I'd fully support it :-)
