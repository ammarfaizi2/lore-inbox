Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271660AbRHUNjQ>; Tue, 21 Aug 2001 09:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271664AbRHUNjG>; Tue, 21 Aug 2001 09:39:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41373 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271660AbRHUNiu>;
	Tue, 21 Aug 2001 09:38:50 -0400
Date: Tue, 21 Aug 2001 06:39:00 -0700 (PDT)
Message-Id: <20010821.063900.112292626.davem@redhat.com>
To: jes@sunsite.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <d3elq5a6au.fsf@lxplus015.cern.ch>
In-Reply-To: <20010821.055856.08326920.davem@redhat.com>
	<d3elq5a6au.fsf@lxplus015.cern.ch>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jes Sorensen <jes@sunsite.dk>
   Date: 21 Aug 2001 15:31:05 +0200
   
   Alan did after I pointed out to him that it was incompatible with the
   GPL (BSD license with advertisement clause). Really hard to fix unless
   you get QLogic to change the license for you.

And what about the Qlogic,ISP firmware in the tree too?  Those have no
copyright notice, but I think this is due to omission.  The same
identical firmware code in Matt Jacob's isp_dist.tar.gz driver has the
BSD license at the top of every firmware file.

You might as well remove all of these drivers in whole, as they are
basically non-functional without the accompanying firmware.

Later,
David S. Miller
davem@redhat.com
