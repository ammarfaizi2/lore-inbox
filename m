Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVAJRxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVAJRxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVAJRul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:50:41 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:23787 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S262370AbVAJRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:24:37 -0500
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: linux-kernel@vger.kernel.org
Subject: Re: printk output to file
Date: Mon, 10 Jan 2005 21:24:18 +0400
User-Agent: KMail/1.6.2
References: <20050110082633.4796.qmail@web60605.mail.yahoo.com>
In-Reply-To: <20050110082633.4796.qmail@web60605.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501102124.18932.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon January 10 2005 12:26 pm, selvakumar nagendran wrote:
> Hello linux-experts,
>     I want to redirect the output of printk from my
> kernel module to a file. If that's possible how can I
Don't redirect, The printk's would be in your syslog. Check your syslog .. 
simple.

Manu
> do that? Please also give some sample code.
>
> Thanks,
> selva
>
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
