Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWEKIj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWEKIj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbWEKIj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:39:57 -0400
Received: from ex.2n.cz ([213.29.92.11]:2784 "EHLO ex.2n.cz")
	by vger.kernel.org with ESMTP id S965208AbWEKIj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:39:57 -0400
Subject: Re: [PATCH] DS1337 RTC subsystem driver
From: Ladislav Michl <michl@2n.cz>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: James Chapman <jchapman@katalix.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060505183209.67e22e77@inspiron>
References: <20060505154322.GA7078@linux-mips.org>
	 <20060505183209.67e22e77@inspiron>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 10:40:30 +0200
Message-Id: <1147336830.4437.6.camel@orphique>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 18:32 +0200, Alessandro Zummo wrote:
>   there's a similar patch that has been posted here (and probably
>  merged in -mm) by David Brownell on 20050416. It should work with
>  DS1307, 37 and 39. You might want to give it a look to see
>  if it satisfies your needs.
Hi,

indeed it is in -mm tree (I'm sorry for not looking there first) and
works nicely 'out of the box'. I hope it will be merged soon to
mainline.

Best regards,
	ladis
