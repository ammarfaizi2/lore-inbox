Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316240AbSELAyB>; Sat, 11 May 2002 20:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316242AbSELAyA>; Sat, 11 May 2002 20:54:00 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:28428 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S316240AbSELAx7>; Sat, 11 May 2002 20:53:59 -0400
Date: Sun, 12 May 2002 10:55:37 +1000
From: john slee <indigoid@higherplane.net>
To: Nicholas Harring <nharring@hostway.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Pedro M. Rodrigues" <pmanuel@myrealbox.com>, chen_xiangping@emc.com,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
Message-ID: <20020512005537.GG3855@higherplane.net>
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A42@srgraham.eng.emc.com> <3CDBFF5B.32550.1364FB2@localhost> <3CDBE7EB.9060605@mandrakesoft.com> <3CDBEC6A.9020600@hostway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 10:51:06AM -0500, Nicholas Harring wrote:
> And how about when an SMP system isn't enough? Should I have to 
> re-engineer my network storage architecture when hardware exists that'll 
> increase throughput if a simple device driver gets written? Don't forget 
> that with 64 bit PCI that the limit of the bus has been raised, and with 

jeff merkey has already demonstrated 300MiB/sec and higher speeds on x86
linux, with 3ware raid and dolphin sci cards.  how much faster do you
need to go?

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
