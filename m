Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVAGTRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVAGTRn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVAGTPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:15:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36350 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261539AbVAGTOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:14:39 -0500
Date: Fri, 7 Jan 2005 11:14:30 -0800
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
       Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050107191430.GC30051@kroah.com>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com> <20050106194646.GB5481@kroah.com> <20050107091218.GA3715@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107091218.GA3715@orphique>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:12:19AM +0100, Ladislav Michl wrote:
> On Thu, Jan 06, 2005 at 11:46:46AM -0800, Greg KH wrote:
> > Ok, can someone send me the proper patch then?
> 
> Index: drivers/i2c/algos/Kconfig

Applied, thanks.

greg k-h
