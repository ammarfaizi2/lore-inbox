Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUAFAJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266050AbUAFAIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:08:54 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:1545 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266046AbUAFAIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:08:36 -0500
Date: Tue, 6 Jan 2004 00:08:34 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christian Schmidt <GMSmith@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug-Report, Linux 2.6.0
In-Reply-To: <3FE1C843.70608@gmx.net>
Message-ID: <Pine.LNX.4.44.0401060008100.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try the latest fbdev patch

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


On Thu, 18 Dec 2003, Christian Schmidt wrote:

> When starting up the new Kernel 2.6.0 in vesa-fb mode, german umlauts 
> (and possibly other special characters) aren't displayed properly. 
> Problem has been there since test9 or even earlier versions.
> 
> When trying to access a RIO 500 mp3-player through the tools from 
> rio500.sf.net, the rio freezes and needs to be unplugged and the battery 
> needs to be removed to make it revert to its normal state. It's not 
> possible to up- or download files on or from it. Problem has been there 
> since test9 or even earlier aswell.
> 
> Regards, Christian Schmidt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

