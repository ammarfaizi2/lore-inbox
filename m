Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGORXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGORXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGORXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:23:47 -0400
Received: from isilmar.linta.de ([213.239.214.66]:18668 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261962AbVGORXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:23:47 -0400
Date: Fri, 15 Jul 2005 19:23:46 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 vs. /sbin/cardmgr
Message-ID: <20050715172346.GD3586@isilmar.linta.de>
Mail-Followup-To: Bob Tracy <rct@gherkin.frus.com>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050710184649.GG8758@dominikbrodowski.de> <20050710203722.DCBBDDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710203722.DCBBDDBA1@gherkin.frus.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 10, 2005 at 03:37:22PM -0500, Bob Tracy wrote:
> Dominik Brodowski wrote:
> > On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> > > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
> > 
> > Please post the output of "lspci" and "lsmod" as I'd like to know which
> > kind of PCMCIA bridge is in your notebook.

OK, it's a plain TI1225. Could you try whether the bug is still existent in
2.6.13-rc3, please?

Thanks,
	Dominik
