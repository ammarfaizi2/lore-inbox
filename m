Return-Path: <linux-kernel-owner+w=401wt.eu-S932311AbXAIRyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXAIRyV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbXAIRyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:54:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbXAIRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:54:20 -0500
Date: Tue, 9 Jan 2007 12:54:17 -0500
From: Dave Jones <davej@redhat.com>
To: Alasdair G Kergon <agk@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lvm backwards compatability
Message-ID: <20070109175417.GD10474@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alasdair G Kergon <agk@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20070108230111.GC14548@redhat.com> <20070109151539.GW21980@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109151539.GW21980@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 03:15:39PM +0000, Alasdair G Kergon wrote:
 > On Mon, Jan 08, 2007 at 06:01:11PM -0500, Dave Jones wrote:
 > > Did backwards compatability with old LVM metadata break intentionally
 > > in 2.6.19 ?  I have a volume that mounts just fine in 2.6.18,
 > > but moving to 2.6.19 gets me this..
 >  
 > No - and at first sight that's not a kernel device-mapper problem.
 > 
 > Please grab some diagnostics:
 >   run the lvmdump script (present in the newest packages) or from here:
 > 
 >   http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/LVM2/scripts/lvm_dump.sh?content-type=text/plain&cvsroot=lvm2

pilot error.  got this working now.

thanks,

		Dave

-- 
http://www.codemonkey.org.uk
