Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVICOhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVICOhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVICOhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:37:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55304 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750737AbVICOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:37:49 -0400
Date: Sat, 3 Sep 2005 15:37:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] feature-removal-schedule.txt: remove {,un}register_serial entry
Message-ID: <20050903153743.A4416@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050901231459.GE3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050901231459.GE3657@stusta.de>; from bunk@stusta.de on Fri, Sep 02, 2005 at 01:14:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 01:14:59AM +0200, Adrian Bunk wrote:
> If the feature is removed, there's no need to keep the entry in 
> feature-removal-schedule.txt.

Thanks Adrian, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
