Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291970AbSBUAHY>; Wed, 20 Feb 2002 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292599AbSBUAHD>; Wed, 20 Feb 2002 19:07:03 -0500
Received: from bitmover.com ([192.132.92.2]:58581 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292598AbSBUAG2>;
	Wed, 20 Feb 2002 19:06:28 -0500
Date: Wed, 20 Feb 2002 16:06:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        ssharma@us.ibm.com
Subject: Re: socket API extensions workgroup at OpenGroup needs HELP
Message-ID: <20020220160626.U27423@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
	ssharma@us.ibm.com
In-Reply-To: <200202202257.g1KMv4c04306@devserv.devel.redhat.com> <E16dgPr-000595-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16dgPr-000595-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 20, 2002 at 11:44:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The existing socket API supports zero copy. SGI proved this a long time back
> (Im sure Larry McVoy can give dates). 

Vernon was there long before I was and it worked long before I got there,
all I did was hook up the networking plumbing to the file system plumbing
so that you could move data without copying it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
