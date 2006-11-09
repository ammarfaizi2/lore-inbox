Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965737AbWKIUkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965737AbWKIUkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965652AbWKIUkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:40:01 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:52273 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1161833AbWKIUkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:40:01 -0500
To: Tom Tucker <tom@opengridcomputing.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       openib-general <openib-general@openib.org>,
       Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH 1/1] Unitialized pseudo_netdev accessed in c2_register_device
X-Message-Flag: Warning: May contain useful information
References: <1163017402.8753.13.camel@trinity.ogc.int>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Nov 2006 12:39:46 -0800
In-Reply-To: <1163017402.8753.13.camel@trinity.ogc.int> (Tom Tucker's message of "Wed, 08 Nov 2006 14:23:22 -0600")
Message-ID: <adad57wcq25.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Nov 2006 20:39:47.0218 (UTC) FILETIME=[3207EF20:01C7043F]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, queued for 2.6.19
