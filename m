Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVCORSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVCORSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVCORQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:16:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44246 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261563AbVCORPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:15:47 -0500
Message-ID: <4237182C.2050609@pobox.com>
Date: Tue, 15 Mar 2005 12:15:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@user.it.uu.se>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH][2.6.11] drivers/net/depca.c gcc4 fix
References: <16950.60522.906648.922785@alkaid.it.uu.se>
In-Reply-To: <16950.60522.906648.922785@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Fix
> 
> drivers/net/depca.c: In function 'load_packet':
> drivers/net/depca.c:1829: warning: operation on 'i' may be undefined

I'm looking over these.  Please CC future netdev patches to me and 
netdev@oss.sgi.com.

	Jeff



