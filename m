Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbUCCLce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCCLce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:32:34 -0500
Received: from smtp09.auna.com ([62.81.186.19]:51429 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262447AbUCCLcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:32:31 -0500
Date: Wed, 3 Mar 2004 12:32:29 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-rc1-mm2
Message-ID: <20040303113229.GA4921@werewolf.able.es>
References: <20040302201536.52c4e467.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040302201536.52c4e467.akpm@osdl.org> (from akpm@osdl.org on Wed, Mar 03, 2004 at 05:15:36 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.03, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
> 
> - More VM tweaks and tuneups
> 
> - Added a 4k kernel- and irq-stack option for x86
> 
> - Largeish NFS client update
> 

I can't deselect the crypto API, with the same .config as previous kernels.
Some core driver now depends on it ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (RC1) for i586
Linux 2.6.4-rc1-jam1 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.2mdk))
