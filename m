Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTIPLvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTIPLvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:51:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:14484 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261861AbTIPLvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:51:03 -0400
Date: Tue, 16 Sep 2003 12:50:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: richard.brunner@amd.com
Cc: davidsen@tmr.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916115050.GG26576@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B1E3@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B1E3@txexmtae.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com wrote:
> My concern is trying to prevent 
> the flood of emails where someone thinks they built 
> a "standard" kernel only to  discover that they forgot 
> to select the various suboptions
> and it doesn't work on their processor. I'd like
> to simplfy what the majority of folks need to do
> to get a broadly working kernel.

There's a similar situation with workarounds for buggy IDE chipsets,
CMD640 and RZ1000

-- Jamie

