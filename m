Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbRGGNVo>; Sat, 7 Jul 2001 09:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266162AbRGGNVe>; Sat, 7 Jul 2001 09:21:34 -0400
Received: from tela.iaeste.tuwien.ac.at ([128.130.57.77]:7685 "EHLO
	tela.iaeste.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S266157AbRGGNVZ>; Sat, 7 Jul 2001 09:21:25 -0400
Date: Sat, 7 Jul 2001 15:25:45 +0200
From: Albert Weichselbraun <albert+kernel@iaeste.or.at>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: rtl8139 dhcp-autoconfiguration problem
Message-ID: <20010707152545.B7370@iaeste.or.at>
In-Reply-To: <20010707142145.A6988@iaeste.or.at> <3B470009.2BA7C123@mandrakesoft.com> <20010707150514.A7370@iaeste.or.at> <3B47087E.80C514F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B47087E.80C514F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Jul 07, 2001 at 09:02:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> did you boot with ip=bootp or ip=dhcp or ip=rarp?
no, i didn't - it seems to be that this is required for kernels >2.2.17.
-> now it works - thanks a lot!

greets,
  albert
