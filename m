Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUKAMiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUKAMiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUKAMhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:37:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15366 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261778AbUKAMgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:36:42 -0500
Date: Mon, 1 Nov 2004 12:36:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 8/8]  serial/icom: remove custom 	msleep()
Message-ID: <20041101123634.H3401@flint.arm.linux.org.uk>
Mail-Followup-To: janitor@sternwelten.at, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nacc@us.ibm.com
References: <E1CO20I-0003Gv-Rq@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CO20I-0003Gv-Rq@sputnik>; from janitor@sternwelten.at on Sun, Oct 31, 2004 at 12:47:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 12:47:22AM +0200, janitor@sternwelten.at wrote:
> Any comments would be appreciated.

Applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
