Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268859AbTBZScL>; Wed, 26 Feb 2003 13:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268860AbTBZScL>; Wed, 26 Feb 2003 13:32:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5515
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268859AbTBZSb6>; Wed, 26 Feb 2003 13:31:58 -0500
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rain.wang@mic.com.tw
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5CEF17.4C014A4C@mic.com.tw>
References: <3E5CEF17.4C014A4C@mic.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 19:44:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 16:45, rain.wang wrote:
> Hi,
>     I did HDIO_DRIVE_RESET ioctl, but system hung without any response,
> only printed some mesages from kernel(v2.4.20):
> 
> hda: DMA disabled
> hda: ide_set_handler: handler not null; old=c01ce300, new=c01d4400
> bug: kernel timer added twice at c01ce102
> 
>      would you please help me with it?

Does this still occur on 2.4.21pre. It should be fixed now

