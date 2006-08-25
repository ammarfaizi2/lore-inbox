Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWHYPOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWHYPOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHYPOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:14:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:52763 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964879AbWHYPOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:14:36 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,169,1154934000"; 
   d="scan'208"; a="121150298:sNHT27297200"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Date: Fri, 25 Aug 2006 08:15:09 -0700
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, dwalker@mvista.com, nickpiggin@yahoo.com.au
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
In-Reply-To: <1156504939.3032.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250815.09296.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 25, 2006 4:22 am, Arjan van de Ven wrote:
> New in this version:
> * implemented the various comments on the code
> * implemented a notifier mechanism so that code can serialize on
> latency (Nick) * put the max latency in the ACPI C states file

I like it.  The new notifier mechanism looks good.

Acked-by:  Jesse Barnes <jesse.barnes@intel.com>
