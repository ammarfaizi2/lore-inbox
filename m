Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbRE3FFh>; Wed, 30 May 2001 01:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbRE3FF1>; Wed, 30 May 2001 01:05:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26240 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262596AbRE3FFQ>;
	Wed, 30 May 2001 01:05:16 -0400
Message-ID: <3B147F80.31EC7520@mandrakesoft.com>
Date: Wed, 30 May 2001 01:05:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Rees <dbr@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 still breaks dhcpcd with 8139too
In-Reply-To: <20010529215647.A3955@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> 
> Hi,
> 
> dhcpcd is still broken in 2.4.5 when using the stock 8139too driver as
> referenced in this thread:
> http://marc.theaimsgroup.com/?t=98847229700003&w=2&r=1
> 
> Going back to the 8139too driver in 2.4.3 fixes it.
> 
> I see that Alan has reverted back to the 2.4.3 driver for his ac-series for
> other reasons, hopefully either the old driver will going in to 2.4.6 or the
> new one will get fixed?

I've got one of the two problems fixed here at the test lab, and am
working on the second.  Hopefully this week I'll have this sorted out,
and a driver for you guys to test.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
