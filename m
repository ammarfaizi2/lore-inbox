Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269378AbRHCJdM>; Fri, 3 Aug 2001 05:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRHCJdC>; Fri, 3 Aug 2001 05:33:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269378AbRHCJcn>;
	Fri, 3 Aug 2001 05:32:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15210.28599.661045.381726@pizda.ninka.net>
Date: Fri, 3 Aug 2001 02:32:39 -0700 (PDT)
To: "Utz Bacher" <utz.bacher@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register_inet6addr_notifier
In-Reply-To: <OF119FF657.6688232C-ONC1256A9A.0063BDC0@de.ibm.com>
In-Reply-To: <OF119FF657.6688232C-ONC1256A9A.0063BDC0@de.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Utz Bacher writes:
 > attached is a patch which introduces
 > * register_inet6addr_notifier
 > * unregister_inet6addr_notifier
 > 
 > and exports
 > 
 > * EXPORT_SYMBOL(ndisc_mc_map);
 > * EXPORT_SYMBOL(register_inet6addr_notifier);
 > * EXPORT_SYMBOL(unregister_inet6addr_notifier);

It seems reasonable, applied.

Thanks.

Later,
David S. Miller
davem@redhat.com
