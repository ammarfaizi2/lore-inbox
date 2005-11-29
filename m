Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVK2UCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVK2UCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVK2UCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:02:00 -0500
Received: from solarneutrino.net ([66.199.224.43]:58372 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932374AbVK2UB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:01:59 -0500
Date: Tue, 29 Nov 2005 15:01:53 -0500
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, Kai.Makisara@kolumbus.fi,
       linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com,
       ryan@tau.solarneutrino.net, linux-kernel@vger.kernel.org
Subject: Re: crash on x86_64 - mm related?
Message-ID: <20051129200153.GC6326@tau.solarneutrino.net>
References: <91888D455306F94EBD4D168954A9457C051773FB@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91888D455306F94EBD4D168954A9457C051773FB@nacos172.co.lsil.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 12:53:35PM -0700, Moore, Eric Dean wrote:
> On Tue, 29 Nov 2005 10:44:09 -0500,  Ryan Richter wrote:
> 
> > 
> > Hi, I booted 2.6.14.2 with the MPT fusion performance fix 
> > patch about a
> > week ago on my file server.  The machine crashed lat night 
> > while it was
> > doing backups.  You can see the voluminous kernel output below.
> > 
> 
> I doubt this has anything to do with the fusion performance patches.

I don't think so either, I just wanted to be clear about what was in my
kernel.

Thanks,
-ryan
