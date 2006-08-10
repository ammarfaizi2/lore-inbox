Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWHJMh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWHJMh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWHJMh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:37:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161229AbWHJMh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:37:57 -0400
Message-ID: <44DB289A.4060503@garzik.org>
Date: Thu, 10 Aug 2006 08:37:46 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Gabor Gombas <gombasg@sztaki.hu>
CC: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
In-Reply-To: <20060810123643.GC25187@boogie.lpds.sztaki.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Gombas wrote:
> AFAIR long ago Linus said he'd like just one major number (and thus only
> one naming scheme) for every disk in the system; with /dev/sd* we're now
> getting there.

Yep.  /dev/disk is a long term goal :)

	Jeff


