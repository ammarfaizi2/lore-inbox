Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293758AbSCAUyA>; Fri, 1 Mar 2002 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293755AbSCAUxv>; Fri, 1 Mar 2002 15:53:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293753AbSCAUxk>;
	Fri, 1 Mar 2002 15:53:40 -0500
Message-ID: <3C7FEA55.2EFFA878@mandrakesoft.com>
Date: Fri, 01 Mar 2002 15:53:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
        aferber@techfak.uni-bielefeld.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <E16gu8n-000515-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 2) IIRC Alan or somebody is trying to get rid of CONFIG_xxx_MODULE,
> > because it doesn't really cover the case of when somebody builds VLAN
> > "later on" as a module, but disables it initially.
> 
> News to me

Oops, Arjan says it was David Woodhouse.  (note I carefully covered my
failing memory with "or somebody" above :):))

Anyway, using CONFIG_xxx_MODULE has the problem I describe above.

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
