Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751970AbWFUFp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWFUFp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWFUFp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 01:45:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751115AbWFUFp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 01:45:58 -0400
Date: Wed, 21 Jun 2006 01:45:52 -0400
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>, davej@codemonkey.org.uk,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] cpufreq: fix powernow-k8 load bug
Message-ID: <20060621054552.GB7606@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <randy.dunlap@oracle.com>, davej@codemonkey.org.uk,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <4498DA08.1010309@oracle.com> <20060621054144.GA7606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621054144.GA7606@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:41:44AM -0400, Dave Jones wrote:
 > On Tue, Jun 20, 2006 at 10:32:56PM -0700, Randy Dunlap wrote:
 >  > Fix powernow-k8 doesn't load bug.
 >  > Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/35145
 >  > 
 >  > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=dce0ca36f2ae348f005735e9acd400d2c0954421
 > 
 > Already fixed in -git1

My bad, I mixed it up with the similar fix for powernow-k7.
I'll queue this up tomorrow morning.

thanks,

		Dave
-- 
http://www.codemonkey.org.uk
