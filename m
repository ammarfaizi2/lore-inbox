Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271939AbTGYIUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271964AbTGYIUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:20:52 -0400
Received: from mail.zmailer.org ([62.240.94.4]:58602 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S271939AbTGYIUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:20:51 -0400
Date: Fri, 25 Jul 2003 11:35:59 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Deepak <guddadabhoota@yahoo.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: IGMPv3 & kernel 2.6
Message-ID: <20030725083559.GB6898@mea-ext.zmailer.org>
References: <20030724082659.26474.qmail@web41906.mail.yahoo.com> <20030725075503.37011.qmail@web41904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725075503.37011.qmail@web41904.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 12:55:03AM -0700, Deepak wrote:
> Hello,
>     Does 2.6 has igmpv3 host stack ? if not, which
> version of kernel (stable) currently available
> supports IGMPv3 host stack ?

You are referring to RFC 2236/3376 ?

The 2.6 has it, while 2.4 does not.
Back-portting is possible.

> -Deepak

/Matti Aarnio
