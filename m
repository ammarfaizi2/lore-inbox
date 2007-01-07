Return-Path: <linux-kernel-owner+w=401wt.eu-S932300AbXAGCAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbXAGCAb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXAGCAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:00:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:12743 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbXAGCAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:00:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=pz2N95wd1xe6PvhumxmVBdl7Q2Z92IcPhT5Wx5BY0uEAZENed84HG7ae6jAgshR3QP/AM4vK3F5uMkpeUND0Vwuu1MM3fcOGwHVYql/HXGJf/Seg34VFDO9LiFkTfp/j5CbCSAvAYENSlBCjEBCzWqJXm/+QvB39fHGWx5hl4Cs=
Date: Sun, 7 Jan 2007 04:00:10 +0200
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-ID: <20070107020010.GH19020@Ahmed>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	linux-kernel@vger.kernel.org
References: <20070106131725.GB19020@Ahmed> <20070106094630.51aa62e8.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106094630.51aa62e8.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 09:46:30AM -0800, Randy Dunlap wrote:

> On Sat, 6 Jan 2007 15:17:25 +0200 Ahmed S. Darwish wrote:
> 
> > Hi all,
> > I'm not able to find the DAC960 block driver maintainer. If someones knows
> > please reply :).
> 
> It's orphaned.  Andrew can decide to merge this, or one of the
> storage or block maintainers could possibly do that.
> or it could go thru KJ, but then Andrew may still end up
> merging it.

Should Kernel janitors then care of cleaning orphaned files ?.
If so, I should forward it to Andrew Morton without CCing LKML again, right ?

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
