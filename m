Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTFPOph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTFPOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:45:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41742 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263898AbTFPOpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:45:31 -0400
Date: Mon, 16 Jun 2003 15:59:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: mikpe@csd.uu.se, Dominik Brodowski <linux@brodo.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 cardbus problem + possible solution
Message-ID: <20030616155922.B13312@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	mikpe@csd.uu.se, Dominik Brodowski <linux@brodo.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <16109.50492.555714.813028@gargle.gargle.HOWL> <20030616153253.A13312@flint.arm.linux.org.uk> <16109.54908.249375.482633@gargle.gargle.HOWL> <1055775186.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055775186.587.2.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Mon, Jun 16, 2003 at 04:53:07PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 04:53:07PM +0200, Felipe Alfaro Solana wrote:
> I must agree with. I think backwards compatibility is important if we
> want widespread adoption of 2.6 from the beginning. But there's a
> question I had in mind for long time: is cardmgr really needed? Isn't
> hotplug more than enough to handle CardBus devices?

We're slowly working towards the point where our reliance on cardmgr
getting less and less.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

