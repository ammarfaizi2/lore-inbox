Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVFGSBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVFGSBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVFGSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:01:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:52918 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261926AbVFGSBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:01:36 -0400
Subject: Re: [PROBLEM] aic7xxx: DV failed to configure device
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Denis Zaitsev <zzz@anda.ru>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050607191646.A30496@ward.six>
References: <20050606141638.A28532@ward.six>
	 <1118045986.5652.21.camel@laptopd505.fenrus.org>
	 <20050606150321.A817@ward.six> <1118068477.5045.27.camel@mulgrave>
	 <20050607191646.A30496@ward.six>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 12:37:03 -0400
Message-Id: <1118162223.4813.40.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 19:16 +0600, Denis Zaitsev wrote:
> It seems that things are in order, do I understand right?  So, why and
> how the low-level format affects the old driver's behaviour?

I can't answer that ... part of the reason for ditching the in-driver
aic7xxx DV is that it was where an astonishing number of bugs kept
turning up.

James


