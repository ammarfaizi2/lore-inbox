Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbTDUPmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTDUPmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:42:16 -0400
Received: from havoc.daloft.com ([64.213.145.173]:56038 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261378AbTDUPmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:42:11 -0400
Date: Mon, 21 Apr 2003 11:54:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 615] New: lots of "irq 5: nobody cared!n" on boot
Message-ID: <20030421155413.GD19954@gtf.org>
References: <28620000.1050940041@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28620000.1050940041@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 08:47:21AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=615
> 
>            Summary: lots of "irq 5: nobody cared!n" on boot
>     Kernel Version: 2.5.68-bk1
>             Status: NEW
>           Severity: low
>              Owner: ambx1@neo.rr.com
>          Submitter: bwindle-kbt@fint.org

Ditto previous email.  Also, I submitted your patch to fix the printk to
Linus.

	Jeff



