Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVCJE7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVCJE7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVCJE5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:57:47 -0500
Received: from isilmar.linta.de ([213.239.214.66]:1668 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261685AbVCJE4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:56:51 -0500
Date: Thu, 10 Mar 2005 05:56:50 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule
Message-ID: <20050310045650.GA14903@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	rddunlap@osdl.org
References: <1110414878721@kroah.com> <1110414879646@kroah.com> <11104148771738@kroah.com> <1110414878721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110414879646@kroah.com> <1110414878721@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 04:34:38PM -0800, Greg KH wrote:
> ChangeSet 1.2036, 2005/03/09 09:31:40-08:00, rddunlap@osdl.org
> 
> [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule
> 
> Add 2.4.x cpufreq /proc and sysctl interface removal
> to the feature-removal-schedule.
> 
> [PATCH] cpufreq 2.4 interface removal schedule
> 
> Even though these 2.4. interfaces are already gone in Dave Jones' cpufreq
> bitkeeper tree, here's a patch which properly announces it in
> Documentation/feature-removal-schedule.txt:


Both already _were_ in Linus' tree; the entry got removed along with the
cpufreq 2.4. interface. So please do not re-add this entry.

	Dominik
