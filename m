Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946263AbWKABaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946263AbWKABaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946262AbWKABaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:30:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:12244 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946263AbWKABaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:30:03 -0500
Message-ID: <4547F899.2070708@garzik.org>
Date: Tue, 31 Oct 2006 20:30:01 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: driver-support@fabric7.com
CC: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/1] Fabric7 VIOC: Ethtool
References: <1161725441.8112.11.camel@rh234.mv.fabric7.com>
In-Reply-To: <1161725441.8112.11.camel@rh234.mv.fabric7.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sriram Chidambaram wrote:
> Ethtool patch for Fabric7 VIOC Device Driver.
> 
> Signed-off-by: Fabric7 Driver-Support <driver-support@fabric7.com>
> ---
>  Makefile.am    |    2 +-
>  ethtool-util.h |    2 ++
>  ethtool.c      |    1 +
>  vioc.c         |   35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletions(-)
> 

applied


