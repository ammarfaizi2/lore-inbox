Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266049AbRF1RWh>; Thu, 28 Jun 2001 13:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRF1RWC>; Thu, 28 Jun 2001 13:22:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47820 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266046AbRF1RVh>; Thu, 28 Jun 2001 13:21:37 -0400
Message-ID: <3B3B6750.5EC2D4E5@vnet.ibm.com>
Date: Thu, 28 Jun 2001 12:20:16 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "David S. Miller" <davem@redhat.com>,
        tgall%rchland.vnet@RCHGATE.RCHLAND.IBM.COM,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <15162.33158.683289.641171@pizda.ninka.net> <3B3B5FCE.EF80E5E9@vnet.ibm.com> <3B3B62D1.A11A4444@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> 2.5 is right around the corner, and sysdata should handle PCI
> domains/segments just fine in 2.4.
> 
> Why do we need to patch 2.4 at all right now?   Since 2.5 is close I
> don't think it's a big deal saying "use 2.5+ for >256 physical buses"

I agree...and we can always maintain a 2.4 patch on the side to handle
the bus limit.

-- 
-todd
