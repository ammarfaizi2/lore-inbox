Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUJZVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUJZVpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUJZVpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:45:15 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:18187 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261485AbUJZVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:45:07 -0400
Date: Tue, 26 Oct 2004 16:44:42 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: marcelo.tosatti@cyclades.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [patch 1/2] cciss: cleans up warnings in the 32/64 bit conversions
Message-ID: <20041026214442.GA4837@beardog.cca.cpqcorp.net>
References: <20041021211718.GA10462@beardog.cca.cpqcorp.net> <1098633262.10824.35.camel@mulgrave> <20041026194551.GA21003@beardog.cca.cpqcorp.net> <1098820685.2061.398.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098820685.2061.398.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 03:57:59PM -0400, James Bottomley wrote:
> On Tue, 2004-10-26 at 15:45, mikem wrote:
> > Which tree are you applying to? This was made from 2.4.28-pre4.
> 
> OK, you caught me ... trying to apply a 2.4 patch to a 2.6 tree.  I keep
> forgetting that not all patches on linux-scsi are 2.6
> 
> James

I should put the kernel version in the subject.

mikem

> 
> 
