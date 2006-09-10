Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWIJUqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWIJUqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWIJUqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:46:18 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:1240 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964924AbWIJUqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:46:17 -0400
Date: Sun, 10 Sep 2006 21:45:16 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
Message-ID: <20060910204516.GA9036@srcf.ucam.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain> <20060910002112.GA20672@kroah.com> <1157913647.5076.174.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157913647.5076.174.camel@mindpipe>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 02:40:46PM -0400, Lee Revell wrote:

> Some applications such as realtime audio and probably gaming require
> ACPI to be disabled, as it causes horrible latency problems.  This
> applies equally to Linux and Windows.

How, and on what hardware?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
