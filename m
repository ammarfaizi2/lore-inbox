Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVALTxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVALTxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVALSyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:54:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40066 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261238AbVALSvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:51:38 -0500
Date: Wed, 12 Jan 2005 10:41:36 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, cpufreq@www.linux.org.uk,
       "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com
Subject: Re: [PATCH] cpufreq 2.4 interface removal schedule [Was: Re: [PATCH] add feature-removal-schedule.txt documentation]
Message-ID: <20050112184135.GB10599@kroah.com>
References: <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <41DEC0BF.4010708@osdl.org> <Pine.LNX.4.58.0501070949410.2272@ppc970.osdl.org> <20050107181131.GA29152@kroah.com> <20050111122309.GA12458@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111122309.GA12458@dominikbrodowski.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:23:09PM +0100, Dominik Brodowski wrote:
> Even though these 2.4. interfaces are already gone in Dave Jones' cpufreq
> bitkeeper tree, here's a patch which properly announces it in
> Documentation/feature-removal-schedule.txt:
> 
> 
> Add meaningful content concerning the removal of deprecated interfaces to
> the cpufreq core.
> 
> Signed-off-by: Dominik Brodowski <linux@brodo.de>

Applied, thanks.

greg k-h
