Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTDVO3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDVO3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:29:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41478 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263176AbTDVO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:29:36 -0400
Date: Tue, 22 Apr 2003 15:41:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: =?iso-8859-1?Q?Thomas_Bogend=F6rfer?= <tsbogend@alpha.franken.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.58+bk: ejecting a pcmcia card: sleeping function from illegal ctx
Message-ID: <20030422154136.A31709@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Riesen <alexander.riesen@synopsys.COM>,
	=?iso-8859-1?Q?Thomas_Bogend=F6rfer?= <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org
References: <20030422122230.GA12110@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030422122230.GA12110@riesen-pc.gr05.synopsys.com>; from alexander.riesen@synopsys.COM on Tue, Apr 22, 2003 at 02:22:30PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 02:22:30PM +0200, Alex Riesen wrote:
> I tried to eject a PCMCIA card (WLinx 10/100, using pcnet driver)
> from this notebook, and got the trace below.

All I'll say at this point is "known problem, fix in progress".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

