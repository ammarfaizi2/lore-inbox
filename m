Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDUPlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbTDUPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:41:31 -0400
Received: from havoc.daloft.com ([64.213.145.173]:54758 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261366AbTDUPla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:41:30 -0400
Date: Mon, 21 Apr 2003 11:53:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 614] New: Oops on boot in vortex_interrupt with 3c59x
Message-ID: <20030421155333.GC19954@gtf.org>
References: <28390000.1050939977@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28390000.1050939977@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 08:46:17AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=614
> 
>            Summary: Oops on boot in vortex_interrupt with 3c59x
>     Kernel Version: 2.5.68-bk1
>             Status: NEW
>           Severity: high
>              Owner: jgarzik@pobox.com
>          Submitter: bwindle-kbt@fint.org

Closed, fix already sent to Linus.

Note that we will have lots of bugs like this in 2.5.68-bk1, until we
get the new interrupt handler return value sorted.

	Jeff



