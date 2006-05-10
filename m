Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWEJWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWEJWBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWEJWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:01:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932305AbWEJWBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:01:19 -0400
Date: Wed, 10 May 2006 15:01:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Brice Goglin <bgoglin@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, <brice@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
Message-ID: <20060510150112.46a732d4@localhost.localdomain>
In-Reply-To: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
References: <446259A0.8050504@myri.com>
	<Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 14:40:22 -0700 (PDT)
Brice Goglin <bgoglin@myri.com> wrote:

> [PATCH 4/6] myri10ge - First half of the driver
> 
> The first half of the myri10ge driver core.
> 

Splitting it in half, might help email restrictions, but it kills
future users of 'git bisect' who expect to have every kernel buildable.
