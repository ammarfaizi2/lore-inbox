Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTE2PlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTE2PlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:41:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:471
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262316AbTE2PlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:41:13 -0400
Subject: Re: siimage driver status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305291059030.11675-100000@bork.hampshire.edu>
References: <Pine.LNX.4.44.0305291059030.11675-100000@bork.hampshire.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054220163.20725.96.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 May 2003 15:56:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 16:00, Wm. Josiah Erikson wrote:
> Wow. I feel dumb. When I add the -X66 to tell the drive as well, then 
> everything is peachy. Thanks! :)

Its hardly obvious. 

> Now I suppose I just have to figure out how to make that work on boot 
> (perhaps just to make the BIOS put them in DMA mode)

One thing I might do is just make the driver ignore the bios policy for
disk devices. 
