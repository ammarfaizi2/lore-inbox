Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270362AbUJTNRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270362AbUJTNRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJTNMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:12:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30986 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270353AbUJTNM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:12:27 -0400
Date: Wed, 20 Oct 2004 14:12:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-bk3 fails compile (serial/8250.c)
Message-ID: <20041020141221.D14627@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Clements <clem@clem.clem-digital.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410201245.i9KCjemA012862@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410201245.i9KCjemA012862@clem.clem-digital.net>; from clem@clem.clem-digital.net on Wed, Oct 20, 2004 at 08:45:40AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:45:40AM -0400, Pete Clements wrote:
> fyi:

It's known:

On Wed, 20 Oct 2004 08:59:18 +0100, Russell King wrote:
> And the fix has been posted on this very mailing list shortly after the
> problem code was merged:
>
>  Subject: [PATCH] Fix serial breakage in -bk3
>  Date:   Tue, 19 Oct 2004 23:47:16 +0100
>  Message-ID: <20041019234716.D20243@flint.arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
