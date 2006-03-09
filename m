Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWCIXzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWCIXzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWCIXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:55:18 -0500
Received: from mx.pathscale.com ([64.160.42.68]:15753 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752063AbWCIXzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:55:16 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada4q27fban.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:55:16 -0800
Message-Id: <1141948516.10693.55.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:28 -0800, Roland Dreier wrote:

> Why are you doing SetPageReserved?  As I understand things, the
> reserved bit is deprecated because it doesn't really have any defined
> semantics...

News to me :-)

Any idea what I should be using instead?

	<b

