Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTB1MW2>; Fri, 28 Feb 2003 07:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267812AbTB1MW2>; Fri, 28 Feb 2003 07:22:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9617
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267807AbTB1MW0>; Fri, 28 Feb 2003 07:22:26 -0500
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "rain.wang" <rain.wang@mic.com.tw>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5EEDF9.5906D73E@mic.com.tw>
References: <3E5CEF17.4C014A4C@mic.com.tw>
	 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
	 <3E5EEDF9.5906D73E@mic.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046439323.16779.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 13:35:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 05:04, rain.wang wrote:
> > Does this still occur on 2.4.21pre. It should be fixed now
> 
> I had tested 'hdparm -w /dev/hda' under 2.4.21-pre4, but problem sill exist,
> 
> just same message as in 2.4.20.

What controller are you using and I'll look into it a bit further

