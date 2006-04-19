Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDSJ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDSJ4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWDSJ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:56:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7370 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750867AbWDSJ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:56:30 -0400
Message-ID: <4446094B.3070809@garzik.org>
Date: Wed, 19 Apr 2006 05:56:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI quirk: VIA IRQ fixup should only run for VIA southbridges
References: <20060419065709.GA8075@taniwha.stupidest.org>
In-Reply-To: <20060419065709.GA8075@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
> on my system which has no VIA southbridge (but I do have a VIA IEEE
> 1394 device).
> 
> This should address that.  I also changed "Via IRQ" to "VIA IRQ"
> (initially I read Via as a capitalized via (by way/means of).

ACK


