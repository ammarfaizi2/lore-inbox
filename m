Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967220AbWK2OQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967220AbWK2OQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967214AbWK2OQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:16:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18634 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S967209AbWK2OQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:16:49 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] use probe_kernel_address in Dwarf2 unwinder
Date: Wed, 29 Nov 2006 15:16:43 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <456D79AB.76E4.0078.0@novell.com> <200611291415.13169.ak@suse.de> <456DA0EA.76E4.0078.0@novell.com>
In-Reply-To: <456DA0EA.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291516.43641.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 15:02, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 29.11.06 14:15 >>>
> >On Wednesday 29 November 2006 12:14, Jan Beulich wrote:
> >> Use probe_kernel_address() instead of __get_user() in Dwarf2 unwinder.
> >
> >I had already done this here. Thanks.
> 
> I had checked firstfloor and only found similar changes to arch/x86-64/.

Sorry I hadn't pushed the changes out yet (did it last night) 

-Andi
