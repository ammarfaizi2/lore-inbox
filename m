Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752848AbWKCAJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbWKCAJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbWKCAJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:09:43 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47825 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752848AbWKCAJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:09:42 -0500
Message-ID: <454A88C3.1060608@garzik.org>
Date: Thu, 02 Nov 2006 19:09:39 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question for today
References: <20061103104818.f280a003.sfr@canb.auug.org.au>
In-Reply-To: <20061103104818.f280a003.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Does vmalloc() zero the memory it allocates?

Nope.

	Jeff



