Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSAOMyl>; Tue, 15 Jan 2002 07:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289555AbSAOMyb>; Tue, 15 Jan 2002 07:54:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28578 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289551AbSAOMyU>;
	Tue, 15 Jan 2002 07:54:20 -0500
Date: Tue, 15 Jan 2002 04:52:44 -0800 (PST)
Message-Id: <20020115.045244.64225720.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        kern0201@siscom.net
Subject: Re: Significant Slowdown Occuring in 2.2 starting with 19pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p733d17kcdv.fsf@oldwotan.suse.de>
In-Reply-To: <200201150402.XAA08887@leros.siscom.net.suse.lists.linux.kernel>
	<E16QSuJ-0004y1-00@the-village.bc.nu.suse.lists.linux.kernel>
	<p733d17kcdv.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 15 Jan 2002 13:49:16 +0100

   Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
   > 
   > The only change in 2.2.19pre2 is the merge of Andrea Arcangeli's VM. Please
   > talk to Andrea and see if he can work out why
   
   Also the merge of blkdev-in-pagecache.

Andi, 2.2.x not 2.4.x :-)

