Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313566AbSDZA4m>; Thu, 25 Apr 2002 20:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313567AbSDZA4l>; Thu, 25 Apr 2002 20:56:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13717 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313566AbSDZA4l>;
	Thu, 25 Apr 2002 20:56:41 -0400
Date: Thu, 25 Apr 2002 17:46:59 -0700 (PDT)
Message-Id: <20020425.174659.107189291.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: AW: Re: AW: Re: AW: Re: VLAN and Network
 Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <156651750.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Thu, 25 Apr 2002 15:45:59 +0200

   > No, "challenged" means "cannot handle".  Do not invert the meaning,
   > the macro says what the meaning is.
   
   Why not call it NETIF_F_VLAN ?
    
BTW, your mail client's mangling of subject lines is REALLY ANNOYING.

We don't call it NETIF_F_VLAN because the hope is that eventually
it will be rare for a network device to not be able to support it.
Not the other day around.

Please fix your mail client before replying anymore, ok?  Thanks.

Franks a lot,
David S. Miller
davem@redhat.com
