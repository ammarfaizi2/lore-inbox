Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTLLRzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTLLRzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:55:49 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:13215 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261744AbTLLRzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:55:49 -0500
Date: Fri, 12 Dec 2003 09:55:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backport ide-cd cdrecord support to 2.4
Message-ID: <20031212175542.GK15401@matchmail.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20031211230830.GJ15401@matchmail.com> <20031212074414.GO7599@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212074414.GO7599@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 08:44:14AM +0100, Jens Axboe wrote:
> On Thu, Dec 11 2003, Mike Fedyk wrote:
> > If there's one feature that I'd love to see in 2.4 it's eliminating my need
> > for ide-scsi completely. :)
> 
> Well that's not going to happen. It's not an isolated feature, it's a
> small addon to the new block io infrastructure in 2.6.

Drat, I didn't realize it depended on the BIO infrastructure.

Thanks for clairifying.
