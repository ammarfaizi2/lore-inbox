Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSDXRuZ>; Wed, 24 Apr 2002 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSDXRuW>; Wed, 24 Apr 2002 13:50:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19589 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312447AbSDXRuG>;
	Wed, 24 Apr 2002 13:50:06 -0400
Date: Wed, 24 Apr 2002 10:40:37 -0700 (PDT)
Message-Id: <20020424.104037.109544858.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <210844917.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Wed, 24 Apr 2002 19:42:24 +0200

   > Von: <davem@redhat.com>
   > Gesendet: 24.04.2002 19:10
   > Yes, the "cannot do VLAN" flag is there in 2.4.x
   
   Mhh, did not found the symbol in netdevice.h on stock 2.4.18.
   
See 2.4.19-preX
