Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTIBKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbTIBKgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:36:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22533 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263676AbTIBKgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:36:15 -0400
Date: Tue, 2 Sep 2003 11:36:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Willemoes Hansen <mwh@sysrq.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
Message-ID: <20030902113610.D29984@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Willemoes Hansen <mwh@sysrq.dk>,
	linux-kernel@vger.kernel.org
References: <1062498150.356.9.camel@spiril.sysrq.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062498150.356.9.camel@spiril.sysrq.dk>; from mwh@sysrq.dk on Tue, Sep 02, 2003 at 12:22:30PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:22:30PM +0200, Martin Willemoes Hansen wrote:
> Hi! Im getting an error when using my Airo PCMCIA WiFi card with the
> 2.4.20, 2.4.21, 2.4.22 kernel. 
> It works when im using 2.4.19 and lower.
> 
> The error message:
> cardmgr[19]: starting, version is 3.2.4
> cs: memory probe 0x0c0000-0x0ffff: excluding 0xc0000-0xcbfff

This isn't an error message as such.  It's the result of checking whether
the memory in the specified range is actually available.

Can you describe the problem you're experiencing in any more detail
please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

