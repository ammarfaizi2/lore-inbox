Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbRLTCsJ>; Wed, 19 Dec 2001 21:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285849AbRLTCr7>; Wed, 19 Dec 2001 21:47:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57985 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285857AbRLTCrp>;
	Wed, 19 Dec 2001 21:47:45 -0500
Date: Wed, 19 Dec 2001 18:47:18 -0800 (PST)
Message-Id: <20011219.184718.88473152.davem@redhat.com>
To: cs@zip.com.au
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220133705.A21648@zapff.research.canon.com.au>
In-Reply-To: <20011219171631.A544@burn.ucsd.edu>
	<20011219.172046.08320763.davem@redhat.com>
	<20011220133705.A21648@zapff.research.canon.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Cameron Simpson <cs@zip.com.au>
   Date: Thu, 20 Dec 2001 13:37:05 +1100
   
   (Though an attitude like yours is a core reason Java is
   spreading as slowly as it is - much like Linux desktops...)
   
It's actually Sun's fault more than anyone else's.

   However, heavily threaded apps regardless of language are hardly likely
   to disappear; threads are the natural way to write many many things. And
   if the kernel implements threads as on Linux, then the scheduler will
   become much more important to good performance.

We are not talking about the scheduler, we are talking about
AIO.
