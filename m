Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291564AbSBAGBk>; Fri, 1 Feb 2002 01:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291563AbSBAGBU>; Fri, 1 Feb 2002 01:01:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62082 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291562AbSBAGBT>;
	Fri, 1 Feb 2002 01:01:19 -0500
Date: Thu, 31 Jan 2002 21:59:43 -0800 (PST)
Message-Id: <20020131.215943.18306187.davem@redhat.com>
To: garzik@havoc.gtf.org
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020131234845.B23792@havoc.gtf.org>
In-Reply-To: <20020131224635.F21864@havoc.gtf.org>
	<20020131.202509.78710127.davem@redhat.com>
	<20020131234845.B23792@havoc.gtf.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <garzik@havoc.gtf.org>
   Date: Thu, 31 Jan 2002 23:48:45 -0500

   I agree with Linus we need metadata files (driver.conf), not
   yanking all that info out of the source code.

I'm perfectly fine with this too.
