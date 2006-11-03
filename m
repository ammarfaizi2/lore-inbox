Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753386AbWKCQ7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbWKCQ7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbWKCQ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:59:41 -0500
Received: from mga05.intel.com ([192.55.52.89]:23473 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1753386AbWKCQ7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:59:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,386,1157353200"; 
   d="scan'208"; a="11284654:sNHT23923233"
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Adrian Bunk <bunk@stusta.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org
In-Reply-To: <20061103021145.GD13381@stusta.de>
References: <1162485897.10806.72.camel@localhost.localdomain>
	 <m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
	 <1162492453.10806.75.camel@localhost.localdomain>
	 <20061103021145.GD13381@stusta.de>
Content-Type: text/plain
Organization: Intel
Date: Fri, 03 Nov 2006 08:10:16 -0800
Message-Id: <1162570216.10806.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 03:11 +0100, Adrian Bunk wrote:

> 
> What's your CONFIG_NR_CPUS setting that you are seeing such a big
> regression?
> 

CONFIG_NR_CPUS is set to 8.  

Tim
