Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSG2MiE>; Mon, 29 Jul 2002 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSG2MiE>; Mon, 29 Jul 2002 08:38:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50423 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317034AbSG2MiE>; Mon, 29 Jul 2002 08:38:04 -0400
Subject: Re: drm error messages when using agpgart in 2.4.18/2.4.19-rc3(aa3)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020729122642Z316530-685+19927@vger.kernel.org>
References: <20020729122642Z316530-685+19927@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 14:56:46 +0100
Message-Id: <1027951006.808.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 13:33, Srihari Vijayaraghavan wrote:
> [X.] Other notes, patches, fixes, workarounds:
> Using: XFree86 4.1.0 (as in Debian Woody 3.0 r0)
> Using Driver "radeon", under "Device" section in XF86Config-4 file.
> 
> I initially thought I will post it to dri/xfree86 mailing lists, since it 
> happens only if I have 'agpgart' support in the kernel, I begin to think 
> kernel mailing list may be the appropriate forum. Please correct me if I am 
> wrong.

XFree86 and the kernel DRI modules as well as AGP all have a close
relationship. If you are doing 3D you really should consider upgrading
to XFree86 4.2.0. That has very large numbers of fixes and improvements
over 4.1.0

Alan

