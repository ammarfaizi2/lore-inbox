Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRK0BNY>; Mon, 26 Nov 2001 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282709AbRK0BNO>; Mon, 26 Nov 2001 20:13:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46723 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282707AbRK0BNK>;
	Mon, 26 Nov 2001 20:13:10 -0500
Date: Mon, 26 Nov 2001 17:13:01 -0800 (PST)
Message-Id: <20011126.171301.50592818.davem@redhat.com>
To: akpm@zip.com.au
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Release Policy
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C02E682.4CDC6858@zip.com.au>
In-Reply-To: <4.3.2.7.2.20011126113409.00bfaa70@mail.osagesoftware.com>
	<Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva>
	<3C02E682.4CDC6858@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Mon, 26 Nov 2001 17:04:02 -0800
   
   Marcelo, if someone sends you a patch which has not been thoroughly
   reviewed on the appropriate mailing list, I would urge you to
   peremptorily shitcan it.  There is no reason why you alone should
   be responsible for reviewing kernel changes.

Are you suggesting that, for example, I should send every Sparc change
to this list?

I bet a lot of what he is seeing are driver and arch updates.

Such updates really only need to go through his "stupid filter"
when it is coming from the maintainer, but it does add up and
take up time.
