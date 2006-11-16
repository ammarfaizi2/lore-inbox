Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424093AbWKPOVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424093AbWKPOVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424079AbWKPOVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:21:51 -0500
Received: from zakalwe.fi ([80.83.5.154]:5843 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1424093AbWKPOVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:21:51 -0500
Date: Thu, 16 Nov 2006 16:21:43 +0200
From: Heikki Orsila <shd@zakalwe.fi>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diabling interrupts on pentium 4 processor
Message-ID: <20061116142143.GB12227@zakalwe.fi>
References: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 11:23:12AM +0000, ranjith kumar wrote:
> Hi,
>     How to disable interrupts on pentium 4 (or any
> i386)
>     machine?
> 
>      I tried to include "cli" instruction in a kernel
> module. But got runtime error.

Read Documentation/cli-sti-removal.txt.

 - Heikki
