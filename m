Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVATXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVATXYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVATXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:24:30 -0500
Received: from waste.org ([216.27.176.166]:48076 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261634AbVATXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:21:38 -0500
Date: Thu, 20 Jan 2005 15:21:22 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, ajoshi@shell.unixbox.com,
       Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: Radeon framebuffer weirdness in -mm2
Message-ID: <20050120232122.GF3867@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.

-- 
Mathematics is the supreme nostalgia of our time.
