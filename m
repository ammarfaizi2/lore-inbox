Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVDEOWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVDEOWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDEOW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:22:28 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:44162 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261750AbVDEOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:20:17 -0400
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other
	places into prep_fn()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42522DD9.7020601@gmail.com>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.94FFEC1E@htj.dyndns.org>
	 <1112292464.5619.30.camel@mulgrave> <20050401052542.GG11318@htj.dyndns.org>
	 <1112639944.5813.66.camel@mulgrave> <42522DD9.7020601@gmail.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 09:20:13 -0500
Message-Id: <1112710813.5764.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 15:19 +0900, Tejun Heo wrote:
>   No problem.  Do you want me to do that now?  Or is it okay to do the 
> next take after you review the request_fn rewrite patch?

Just on resubmit ... I think you're currently reworking the request_fn
patch based on Christoph's comments, so resend the sequence when you
have this.

Thanks,

James


