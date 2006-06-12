Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWFLU5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWFLU5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWFLU5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:57:49 -0400
Received: from rtr.ca ([64.26.128.89]:13280 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751349AbWFLU5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:57:48 -0400
Message-ID: <448DD54B.5040600@rtr.ca>
Date: Mon, 12 Jun 2006 16:57:47 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Clayton <andrew@digital-domain.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: VMSPLIT kernel config option
References: <20060612215434.0b8c873f@alpha.digital-domain.net>
In-Reply-To: <20060612215434.0b8c873f@alpha.digital-domain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clayton wrote:
> Hi,
> 
> Is it meant, that the VMSPLIT_* options are only enabled 
> "if EMBEDDED"?
> 
> See line 470 of arch/i386/Kconfig
> 
> This is with 2.6.17-rc6-git4

Heh.. it took me a while to find that change, too.
