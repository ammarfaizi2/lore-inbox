Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbTGIPu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbTGIPu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:50:27 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:3309 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S268396AbTGIPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:50:24 -0400
Date: Wed, 9 Jul 2003 12:04:45 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andreas Schwab <schwab@suse.de>
Cc: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.15 'insmod'
Message-ID: <20030709160445.GE21969@ti19>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andreas Schwab <schwab@suse.de>, root@chaos.analogic.com,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307091119450.470@chaos> <jer84zln59.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jer84zln59.fsf@sykes.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 05:45:22PM +0200, Andreas Schwab wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> |> It is likely that malloc(0) returning a valid pointer is a bug
> |> that has prevented this problem from being observed.
> 
> It's not a bug, it's a behaviour explicitly allowed by the C standard.
 
... and has long been used to generate unique cookies of pointer type.

Regards,

	Bill Rugolsky
