Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVACS4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVACS4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVACSwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:52:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51986 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261769AbVACS1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:27:23 -0500
Date: Mon, 3 Jan 2005 18:27:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: drzeus-wbsd@drzeus.cx, Andrew Morton <akpm@osdl.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>, wbsd-devel@list.drzeus.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix warning in wbsd (fwd)
Message-ID: <20050103182701.B3442@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, drzeus-wbsd@drzeus.cx,
	Andrew Morton <akpm@osdl.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>, wbsd-devel@list.drzeus.cx,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050103180559.GN2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050103180559.GN2980@stusta.de>; from bunk@stusta.de on Mon, Jan 03, 2005 at 07:05:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 07:05:59PM +0100, Adrian Bunk wrote:
> The patch forwarded below by Pierre Ossman <drzeus-list@drzeus.cx> still
> applies and compiles against 2.6.10-mm1.
> 
> Please apply.

Please don't - I'll apply it via my MMC tree shortly.  I want to kill
data->req, so it makes sense to wrap this up into that series of changes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
