Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWHPUej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWHPUej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWHPUej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:34:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:28042 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750843AbWHPUei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:34:38 -0400
Message-ID: <44E38157.4070805@garzik.org>
Date: Wed, 16 Aug 2006 16:34:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
       Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
References: <20060811170337.GH10638@austin.ibm.com> <20060816161856.GD20551@austin.ibm.com> <44E34825.2020105@garzik.org> <20060816203043.GJ20551@austin.ibm.com>
In-Reply-To: <20060816203043.GJ20551@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> I was under the impression that NAPI was for the receive side only.

That depends on the driver implementation.

	Jeff


