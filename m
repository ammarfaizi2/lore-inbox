Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTEOMAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTEOMAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 08:00:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62212 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263973AbTEOMAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:00:46 -0400
Date: Thu, 15 May 2003 13:13:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-ID: <20030515131333.C30619@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052998601.726.1.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Thu, May 15, 2003 at 01:36:41PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you send me the results of that patch, could you also include:

- /proc/modules (from before the crash)
- all kernel messages

please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

