Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUEMOHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUEMOHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEMOHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:07:18 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:7179 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264212AbUEMOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:05:55 -0400
Subject: Re: [PATCH] AES i586 optimized
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Fruhwirth Clemens <clemens-dated-1085312570.422b@endorphin.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040513114250.GB22233@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
	 <20040513040732.75c5999c.akpm@osdl.org>
	 <20040513114250.GB22233@ghanima.endorphin.org>
Content-Type: text/plain
Message-Id: <1084457158.1737.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 13 May 2004 16:05:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 13:42, Fruhwirth Clemens wrote:
> > 
> > Some benchmark figures would be useful.  Cache-cold and cache-hot.
> 
> I posted this patch for the first time about 3/4 year ago. The first
> response has been the same. Please have a look at

I'll give this a spin, since I'm very interested in AES. Currently, I'm
using IPSec with AES ESP all over my 100Mbps LAN. I'll apply this one to
2.6.6-mm2 and will compare with vanillas 2.6.6 and 2.6.6-mm2.

