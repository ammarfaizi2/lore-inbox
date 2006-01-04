Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWADWu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWADWu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWADWu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:50:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24840 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030318AbWADWu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:50:56 -0500
Date: Wed, 4 Jan 2006 22:50:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Patrick Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6] Altix - ioc3 serial support
Message-ID: <20060104225049.GG3119@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com> <43BC377E.3050603@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BC377E.3050603@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:00:46PM -0600, Patrick Gefre wrote:
> There hasn't been any further comments on this - I'm guessing it's ready to 
> go.

Have you addressed my comments?  It's unclear from this email whether
the below is updated or not - the diffstat looks identical to the
version I reviewed a while back.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
