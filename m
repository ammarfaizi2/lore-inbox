Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCUAmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCUAmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVCUAmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:42:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:42220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261350AbVCUAmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:42:17 -0500
Date: Sun, 20 Mar 2005 16:41:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: viking <viking@flying-brick.caverock.net.nz>
Cc: linux-kernel@vger.kernel.org, wakko@animx.eu.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB mouse hiccups (was RFD: Kernel release numbering)
Message-Id: <20050320164129.44d3a065.akpm@osdl.org>
In-Reply-To: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viking <viking@flying-brick.caverock.net.nz> wrote:
>
> I did note something strange. I'm running 2.6.11.2 at this moment, when I
>  tried 2.6.11.3, my USB Microsoft Wireless Optical Mouse stopped moving
>  from left to right, and would only move up and down if I physically moved
>  the mouse from left to right. I didn't see anything in the patches that
>  touched anything in the event handling, so frankly I'm puzzled.
>  Any clues as to where I need to look? I've seen this problem before, but
>  don't know what causes it, nor how I fixed it at the time.
>  Also, how do I get that patch that enables the tiltwheel (left-right
>  events)?

Could you please test 2.6.12-rc1?
