Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTJCAgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTJCAgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:36:43 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:6410 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263528AbTJCAgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:36:43 -0400
Subject: Re: [PATCH] Net device error logging
From: Joe Perches <joe@perches.com>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F7C967F.A06A512E@us.ibm.com>
References: <3F7C967F.A06A512E@us.ibm.com>
Content-Type: text/plain
Message-Id: <1065141377.6667.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 02 Oct 2003 17:36:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 14:19, Jim Keniston wrote:
> The enclosed patch, updated for v2.6.0-test6, implements the previously
> discussed netdev_* error-logging macros for network drivers.  Please apply.

While I agree with the completely with the concept and nearly completely
with the implementation, can I suggest that this should be done in the
2.7 series?


