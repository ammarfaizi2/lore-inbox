Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWHASWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWHASWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWHASWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:22:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751764AbWHASWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:22:14 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1154450847.5605.21.camel@localhost> 
References: <1154450847.5605.21.camel@localhost>  <1154354115351-git-send-email-hskinnemoen@atmel.com> <20060731174659.72da734f@cad-250-152.norway.atmel.com> <1154371259.13744.4.camel@localhost> <20060801101210.0548a382@cad-250-152.norway.atmel.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 01 Aug 2006 19:22:02 +0100
Message-ID: <22686.1154456522@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> That 'sec=null' would explain why you are seeing a problem, and the
> attached patch ought to fix it.

I've inserted this patch into my patchset (now version #9) at position 32
after my security fix, and posted the new patchset in the usual place.  Your
git tree carries patches 1-29 currently.

David
