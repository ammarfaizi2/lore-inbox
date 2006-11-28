Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933934AbWK1B5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934AbWK1B5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934190AbWK1B5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:57:51 -0500
Received: from isilmar.linta.de ([213.239.214.66]:1250 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S933934AbWK1B5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:57:50 -0500
Date: Mon, 27 Nov 2006 20:57:48 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Arjan van de Ven <arjan@infradead.org>, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Bug: Pentium M not always detected by CPUFREQ
Message-ID: <20061128015748.GB21472@isilmar.linta.de>
Mail-Followup-To: Holger Schurig <hs4233@mail.mn-solutions.de>,
	Arjan van de Ven <arjan@infradead.org>, cpufreq@lists.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <200611211646.29488.hs4233@mail.mn-solutions.de> <1164128474.31358.682.camel@laptopd505.fenrus.org> <200611220848.03746.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611220848.03746.hs4233@mail.mn-solutions.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:48:03AM +0100, Holger Schurig wrote:
> > you don't have a pentium M
> 
> In that case p4-clockmod has a bug, because it said that I have 
> one.

That bug should be fixed in -mm, cpufreq-git and 2.6.20.

Thanks,
	Dominik
