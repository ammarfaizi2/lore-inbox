Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286129AbRLTFbA>; Thu, 20 Dec 2001 00:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286128AbRLTFav>; Thu, 20 Dec 2001 00:30:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286127AbRLTFaj>;
	Thu, 20 Dec 2001 00:30:39 -0500
Date: Wed, 19 Dec 2001 21:30:19 -0800 (PST)
Message-Id: <20011219.213019.35013739.davem@redhat.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - 32-bit IO support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <9vrmea$mef$1@cesium.transmeta.com>
In-Reply-To: <20011218235024.N13126@flint.arm.linux.org.uk>
	<9vrmea$mef$1@cesium.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: 19 Dec 2001 19:37:46 -0800
   
   You probably need to verify that 32-bit support is available (both on
   the bridge and the peripherals), but if they are, there's no reason
   not to use it on non-x86 architectures...

Don't the PCI specs actually talk about 24-bits in fact?

Russell does you box really have the full 32-bits or is it
really just 24-bits?
