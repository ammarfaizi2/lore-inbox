Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992514AbWJTGTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992514AbWJTGTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992513AbWJTGTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:19:43 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:12217 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S2992512AbWJTGTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:19:42 -0400
Date: Fri, 20 Oct 2006 08:19:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-ID: <20061020061934.GA3735@aepfle.de>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de> <1161308221.10524.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1161308221.10524.92.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, Benjamin Herrenschmidt wrote:

> On CHRP with only a 8259, make sure it's set as the default host.

No errors with this patch.
