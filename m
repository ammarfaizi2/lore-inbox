Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVCKABV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVCKABV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVCJX4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:56:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262985AbVCJXsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:48:00 -0500
Date: Thu, 10 Mar 2005 18:47:48 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
Subject: Re: [PATCH] cpufreq 2.4 interface removal schedule
Message-ID: <20050310234748.GA15995@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org
References: <200503100207.j2A27ImS019757@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503100207.j2A27ImS019757@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 05:32:00PM +0000, Linux Kernel wrote:
 > ChangeSet 1.1994.11.3, 2005/03/09 09:32:00-08:00, linux@dominikbrodowski.de
 > 
 > 	[PATCH] cpufreq 2.4 interface removal schedule
 > 	

 > ChangeSet 1.1994.11.2, 2005/03/09 09:31:40-08:00, rddunlap@osdl.org
 >
 >  [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule

please bk cset -x these. They shouldn't have ended up in your tree since
this stuff got ripped out two months ago.

		Dave

