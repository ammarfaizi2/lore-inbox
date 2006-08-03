Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWHCPqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWHCPqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWHCPqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:46:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932516AbWHCPqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:46:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1154615661.5774.35.camel@localhost> 
References: <1154615661.5774.35.camel@localhost>  <1154354115351-git-send-email-hskinnemoen@atmel.com> <20060731174659.72da734f@cad-250-152.norway.atmel.com> <1154371259.13744.4.camel@localhost> <20060801101210.0548a382@cad-250-152.norway.atmel.com> <1154450847.5605.21.camel@localhost> <20060802094529.09db5532@cad-250-152.norway.atmel.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, Andi Kleen <ak@suse.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 03 Aug 2006 16:46:22 +0100
Message-ID: <10107.1154619982@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Argh... You are quite right. We ought to have fixed the pseudoflavour
> thingy in version 6, and made it mandatory, but we missed the chance...
> 
> Revised patch is attached.

That looks reasonable.

Acked-By: David Howells <dhowells@redhat.com>
