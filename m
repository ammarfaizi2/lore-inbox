Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbTCSRUu>; Wed, 19 Mar 2003 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263083AbTCSRUu>; Wed, 19 Mar 2003 12:20:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31621
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263080AbTCSRUt>; Wed, 19 Mar 2003 12:20:49 -0500
Subject: Re: PATCH: I2O updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048096801.30751.59.camel@irongate.swansea.linux.org.uk>
References: <1048096801.30751.59.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048099352.30751.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 18:42:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 18:00, Alan Cox wrote:
> This brings the I2O layer up to date. It fixes the i2o scsi hang
> on boot. It fixes the stack abuse by the i2o_proc code and it 
> merges i2o_pci into i2o_core. I2O is now dead so no other 
> transports are likely to appear, so this always rather messy
> abstraction can go.

I see I found another bug in evolution. I'll resend them

