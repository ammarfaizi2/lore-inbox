Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWE1PNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWE1PNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWE1PNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 11:13:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750778AbWE1PNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 11:13:48 -0400
Date: Sun, 28 May 2006 11:13:31 -0400
From: Dave Jones <davej@redhat.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: rc5-git1 and later fail to boot on x86_64
Message-ID: <20060528151331.GB2984@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>
References: <4479BC92.1090900@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4479BC92.1090900@mbligh.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 08:06:58AM -0700, Martin J. Bligh wrote:
 > plain -rc5 seems fine. Double checking this isn't a machine issue, but
 > it seems to boot the older kernels just fine.
 > 
 > good boot is here: http://test.kernel.org/abat/33283/debug/console.log
 > for comparison

If rc5 vs rc5-git1 shows a difference in behaviour for you, something
is seriously wrong somewhere, as git1 only contained a single arch/s390 patch.

		Dave

-- 
http://www.codemonkey.org.uk
