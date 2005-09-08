Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVIHMMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVIHMMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVIHMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:12:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46091 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932481AbVIHMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:12:14 -0400
Date: Thu, 8 Sep 2005 13:12:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 0/5] SharpSL: Prepare drivers and add new ARM PXA machines Spitz and Borzoi
Message-ID: <20050908131209.C31595@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007626.8338.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126007626.8338.125.camel@localhost.localdomain>; from rpurdie@rpsys.net on Tue, Sep 06, 2005 at 12:53:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a general note, these patches could do with being closer to the
coding style, such that things like

	foo=bar;
	foo+=bar;

have spaces around the assignment and operators thusly:

	foo = bar;
	foo += bar;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
