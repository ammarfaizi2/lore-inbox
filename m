Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRCGSrH>; Wed, 7 Mar 2001 13:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRCGSq5>; Wed, 7 Mar 2001 13:46:57 -0500
Received: from smtp5vepub.gte.net ([206.46.170.26]:58393 "EHLO
	smtp5ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S131156AbRCGSqu>; Wed, 7 Mar 2001 13:46:50 -0500
Message-ID: <3AA681FB.627E1C83@neuronet.pitt.edu>
Date: Wed, 07 Mar 2001 13:46:19 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.3 and new aic7xxx
In-Reply-To: <3AA5CA13.8C19FC7E@neuronet.pitt.edu> <200103070546.f275keO22502@aslan.scsiguy.com> <984jf1$1hj$1@penguin.transmeta.com> <032e01c0a6d7$645ba140$0300a8c0@methusela>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:
> 
> > I suspect it's easier to just make the PCI layer call the probe function
> > in that order, instead of working around it in your driver. Jeff?
> 
> Would 'pci=reverse' do the trick already?

Get a unknown option warning message when using that.

-- 
     Rafael
