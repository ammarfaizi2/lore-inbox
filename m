Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVCSSVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVCSSVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVCSSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:21:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14094 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262651AbVCSSVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:21:20 -0500
Date: Sat, 19 Mar 2005 18:21:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: DHollenbeck <dick@softplc.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sealevel 8 port RS-232/RS-422/RS-485 board
Message-ID: <20050319182109.A29823@flint.arm.linux.org.uk>
Mail-Followup-To: DHollenbeck <dick@softplc.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <42312EF2.1040505@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42312EF2.1040505@softplc.com>; from dick@softplc.com on Thu, Mar 10, 2005 at 11:38:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 11:38:58PM -0600, DHollenbeck wrote:
> Vendor Sealevel suggested these changes for its new board.  Tried them, 
> they work with the card.  Please apply the patch below, which was made 
> from 2.6.10 but can be applied to 2.6.11.2 without errors.

Whitespace fixed and applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
