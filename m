Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268738AbTBZM7t>; Wed, 26 Feb 2003 07:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268740AbTBZM7t>; Wed, 26 Feb 2003 07:59:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47241
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268738AbTBZM7t>; Wed, 26 Feb 2003 07:59:49 -0500
Subject: Re: Question about DMA and cd burning.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jpiszcz <jpiszcz@lucidpixels.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5C4ECD.7020806@lucidpixels.com>
References: <3E5C4ECD.7020806@lucidpixels.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046268717.8948.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 14:11:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 05:21, jpiszcz wrote:
> Can anyone offer any suggestions why others can burn CD's in DMA mode, 
> yet the kernel keeps disabling DMA for my burners?

It depends on the options your kernel was compiled with

