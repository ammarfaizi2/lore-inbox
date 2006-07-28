Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWG1SlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWG1SlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWG1SlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:41:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:42147 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161221AbWG1SlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:41:10 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 1/5] Add comments to the PDA structure to annotate offsets
Date: Fri, 28 Jul 2006 20:41:38 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102590.6416.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1154102590.6416.11.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282041.38506.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 18:03, Arjan van de Ven wrote:
> Subject: [patch 1/5] Add comments to the PDA structure to annotate offsets
> From: Arjan van de Ven <arjan@linux.intel.com>

So why exactly do you think these numbers need to be documented?

If there is a reason there should be a comment in the code.

Nobody should use fixed numbers, but always get the current ones
from asm-offset

-Andi

> Change the comments in the pda structu
