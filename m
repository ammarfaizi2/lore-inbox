Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTJXL1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 07:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTJXL1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 07:27:54 -0400
Received: from poup.poupinou.org ([195.101.94.96]:38663 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262152AbTJXL1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 07:27:53 -0400
Date: Fri, 24 Oct 2003 13:27:48 +0200
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       cpufreq@www.linux.org.uk, "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031024112748.GB28351@poupinou.org>
References: <CFF522B18982EA4481D3A3E23B83141C24B4DF@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF522B18982EA4481D3A3E23B83141C24B4DF@orsmsx407.jf.intel.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 01:47:49PM -0700, Moore, Robert wrote:
> 
> I would vote for "cpufreq_dynamic"
> 

Name is too generic IMHO.  There are a lot
of other ways to do dynamic switching.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
