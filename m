Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVFVRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVFVRAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVFVQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:56:28 -0400
Received: from bender.bawue.de ([193.7.176.20]:50142 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261630AbVFVQzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:55:12 -0400
Date: Wed, 22 Jun 2005 18:54:56 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: johan.heikkila@netikka.fi
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050622165456.GA15362@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	johan.heikkila@netikka.fi,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050620205334.GA28230@sommrey.de> <20050621202035.GE31391@atomide.com> <Pine.LNX.4.58.0506221917260.11779@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506221917260.11779@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 07:33:32PM +0300, johan.heikkila@netikka.fi wrote:
> 
> I have been running with the 2.6.11-jo3 patch since Joerg made it 
> available. It works fine on my ASUS A7M266-D with two Athlon MP1800+ that 
> is running 24h. I just patched 2.6.12 vanilla kernel and it looks 
> good. I will report if there are any issues.

If you experience any different behaviour between 2.6.11-jo3 and
2.6.12-jo1 I really would like to hear about that.  There are major
differences between those two versions.

-jo

-- 
-rw-r--r--  1 jo users 63 2005-06-21 20:36 /home/jo/.signature
