Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVAMSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVAMSAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVAMR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:59:59 -0500
Received: from fsmlabs.com ([168.103.115.128]:40922 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261247AbVAMR5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:57:53 -0500
Date: Thu, 13 Jan 2005 10:58:13 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Han Boetes <han@mijncomputer.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
In-Reply-To: <20050113163733.GB14127@boetes.org>
Message-ID: <Pine.LNX.4.61.0501131057350.24811@montezuma.fsmlabs.com>
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org>
 <20050113163733.GB14127@boetes.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Han Boetes wrote:

> 
> Thanks for your comments! This wasn't my patch, just the closed
> thing to something working I could find. Here is my version.
> 
> Now all I wonder about is what the _NOVERS should become, since
> Arjen pointed it it `was dead,' since I don't really understand
> what he means with that.

Just use the normal EXPORT_SYMBOL it has the same effect.
