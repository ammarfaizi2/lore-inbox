Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbTCTUbW>; Thu, 20 Mar 2003 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbTCTUbW>; Thu, 20 Mar 2003 15:31:22 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:33796 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261994AbTCTUbU>; Thu, 20 Mar 2003 15:31:20 -0500
Date: Thu, 20 Mar 2003 20:42:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
Message-ID: <20030320204218.A18517@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
References: <20030320195657.GA3270@drcomp.erfurt.thur.de> <874r5xyeky.fsf@sdbk.de> <20030320203407.GF8256@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030320203407.GF8256@gtf.org>; from jgarzik@pobox.com on Thu, Mar 20, 2003 at 03:34:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 03:34:07PM -0500, Jeff Garzik wrote:
> For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> the 2.4.21-pre cycle, that would be less productive than just patching
> 2.4.20 and rolling a separate release off of that.

I think the naming is illogical.  If there's a bugfix-only release
it whould have normal incremental numbers.  So if marcelo want's
it he should clone a tree of at 2.4.20, apply the essential patches
and bump the version number in the normal 2.4 tree to 2.4.22-pre1

