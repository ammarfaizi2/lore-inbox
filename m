Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSAXPnM>; Thu, 24 Jan 2002 10:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288594AbSAXPnD>; Thu, 24 Jan 2002 10:43:03 -0500
Received: from cliff.mcs.anl.gov ([140.221.9.17]:38528 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S288531AbSAXPmr>;
	Thu, 24 Jan 2002 10:42:47 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, jes@trained-monkey.org, linux-acenic@sunsite.dk,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
	<20020124.053652.85395471.davem@redhat.com>
From: "Narayan Desai" <desai@mcs.anl.gov>
Date: Thu, 24 Jan 2002 09:41:26 -0600
In-Reply-To: <20020124.053652.85395471.davem@redhat.com> ("David S.
 Miller"'s message of "Thu, 24 Jan 2002 05:36:52 -0800 (PST)")
Message-ID: <yrxzo33ah95.fsf@catbert.mcs.anl.gov>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-mandrake-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that this change is necessary for 2.4.18pre6 as well.
 -nld
