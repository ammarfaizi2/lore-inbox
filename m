Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVCYSmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVCYSmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCYSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:42:37 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:5286 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261744AbVCYSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:40:04 -0500
Subject: Re: megaraid driver (proposed patch)
From: James Bottomley <jejb@steeleye.com>
To: Bruno Cornec <Bruno.Cornec@hp.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
In-Reply-To: <20050325182252.GA4268@morley.grenoble.hp.com>
References: <20050325182252.GA4268@morley.grenoble.hp.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 12:39:52 -0600
Message-Id: <1111775992.5692.25.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 19:22 +0100, Bruno Cornec wrote:
> Would you consider to apply the following patch proposed by Thierry
> Vignaud as a solution for the MandrakeSoft kernel in the mainstream 2.6 
> kernel ?

Well, to be considered you'd need to cc the megaraid maintainers and the
linux-scsi mailing list.

> -if MEGARAID_NEWGEN=n

No, this is wrong it would break allyes configs and I'd get shot.

James


