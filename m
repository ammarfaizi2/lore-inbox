Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUKTJm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUKTJm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKTJm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:42:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14086 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261345AbUKTJmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:42:25 -0500
Date: Sat, 20 Nov 2004 09:42:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] pcmcia/yenta_socket.c: make cardbus_type static
Message-ID: <20041120094219.D7482@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041113030207.GV2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041113030207.GV2249@stusta.de>; from bunk@stusta.de on Sat, Nov 13, 2004 at 04:02:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 04:02:07AM +0100, Adrian Bunk wrote:
> Since there's no user outside this file, cardbus_type in 
> drivers/pcmcia/yenta_socket.c can be made static.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
