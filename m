Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271718AbTGRMos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271720AbTGRMor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:44:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8915
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271718AbTGRMon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:44:43 -0400
Subject: Re: 2.6.0-test1: Framebuffer problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307171833430.10255-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307171833430.10255-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058533025.19511.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 13:57:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 18:34, James Simmons wrote:
> > > > > CONFIG_FB_VGA16=y 		<---- to many drivers selected. Please 
> > > 				<---- pick only one.
> > > > > CONFIG_FB_VESA=y
> > 
> > This is a completely sensible selection and works as expected in 2.4 so
> > it really wants fixing anyway
> 
> It is if you have more than one graphics card. If you only have one card 
> then you will have problems. 

Then it still needs to be fixed. This works correctly in 2.4

-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
