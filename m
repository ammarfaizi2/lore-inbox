Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWAaEO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWAaEO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 23:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWAaEO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 23:14:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:31465 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030221AbWAaEOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 23:14:25 -0500
Message-ID: <43DEE416.5070804@pobox.com>
Date: Mon, 30 Jan 2006 23:14:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Wall <kwall@kurtwerks.com>
CC: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: Fix make mandocs for libata-core.c
References: <20060131032029.GO1501@kurtwerks.com>
In-Reply-To: <20060131032029.GO1501@kurtwerks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Kurt Wall wrote: > "make mandocs" complains when on
	libata-core.c because several > functions have undescribed parameters.
	This patch adds silences those > warnings by adding descriptions for
	the undescribed parameters. > > Signed-off-by: Kurt Wall
	<kwall@kurtwerks.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> "make mandocs" complains when on libata-core.c because several
> functions have undescribed parameters. This patch adds silences those
> warnings by adding descriptions for the undescribed parameters.
> 
> Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

I appreciate the patches... Alas Randy Dunlap beat you to it.

	Jeff



