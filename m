Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269200AbTCBBCY>; Sat, 1 Mar 2003 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269201AbTCBBCX>; Sat, 1 Mar 2003 20:02:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11416
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269200AbTCBBCW>; Sat, 1 Mar 2003 20:02:22 -0500
Subject: Re: Incorrect 80 wire detection with amd 760mpx & 2.4.21-pre4-ac7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E615645.4010206@netscape.net>
References: <3E615645.4010206@netscape.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046571368.24901.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 02:16:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 00:54, Nicholas Wourms wrote:
> FYI:
> I suspect that: 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104619727013220&w=2
> is related to my problem.
> 
> Anyhow, I'm using a UDMA5 WesternDigital drive on a ASUS 
> K7M266-D motherboard.  With a plain, stock 2.4.20 kernel, 
> the viper driver properly recognizes which channel has the 

Yep. I'll apply the obvious fix if Vojtech doesn't. Its on the known
list

