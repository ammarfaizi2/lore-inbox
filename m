Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWIWEyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWIWEyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 00:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWIWEyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 00:54:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750991AbWIWEyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 00:54:16 -0400
Date: Fri, 22 Sep 2006 21:54:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Restore the original TX FIFO overflow process.
Message-Id: <20060922215411.85ac3f16.akpm@osdl.org>
In-Reply-To: <1158953401.2630.0.camel@localhost.localdomain>
References: <1158953401.2630.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 15:30:01 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

>  #define DRV_NAME	"sundance"
> -#define DRV_VERSION	"1.01+LK1.14"
> -#define DRV_RELDATE	"04-Aug-2006"
> +#define DRV_VERSION	"1.01+LK1.15"
> +#define DRV_RELDATE	"22-Sep-2006"

Can we please delete this thing?  It's *forever* getting rejects and 
people only remember to update it a fraction of the time anyway.
