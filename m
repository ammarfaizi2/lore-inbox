Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWJLSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWJLSDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWJLSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:03:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750719AbWJLSDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:03:33 -0400
Date: Thu, 12 Oct 2006 14:03:21 -0400
From: Dave Jones <davej@redhat.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Judith Lebzelter <judith@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Message-ID: <20061012180321.GD21149@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
	Judith Lebzelter <judith@osdl.org>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com> <20061012001139.1fea6ecf.akpm@osdl.org> <20061012175536.GA8497@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012175536.GA8497@intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 10:55:36AM -0700, Luck, Tony wrote:

 > P.S. Next layer of the onion is CONFIG_BLK_DEV_AMD74XX ... perhaps
 > that needs to be "depends on X86"?

I sent patches to do that a few months ago.
They were shot down due to the alleged value of compile testing on
architectures which will never run those drivers.

	Dave

-- 
http://www.codemonkey.org.uk
