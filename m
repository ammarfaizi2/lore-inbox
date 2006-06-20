Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWFTIDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWFTIDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFTIDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:03:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9670 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965021AbWFTIDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:03:13 -0400
Message-ID: <4497ABAC.4030305@garzik.org>
Date: Tue, 20 Jun 2006 04:02:52 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de>
In-Reply-To: <200606200925.30926.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> So if there are any more MSI problems comming up IMHO it should be white list/disabled 
> by default and only turn on after a long time when Windows uses it by default 
> or something. Greg, do you agree?


We should be optimists, not pessimists.

MSI is useful enough that we should turn it on by default in newer systems.

	Jeff


