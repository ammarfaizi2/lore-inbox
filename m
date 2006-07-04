Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWGDPYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWGDPYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGDPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:24:48 -0400
Received: from homer.mvista.com ([63.81.120.158]:12718 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751196AbWGDPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:24:47 -0400
Subject: Re: [BUG] scsi/io-elevator held lock freed.
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1152026010.3109.66.camel@laptopd505.fenrus.org>
References: <1152024854.29262.5.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1152026010.3109.66.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 08:24:44 -0700
Message-Id: <1152026685.29262.7.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 17:13 +0200, Arjan van de Ven wrote:
> 
> blargh.. it'd be more useful if lockdep actually printed which lock it
> is that it thinks is about to get freed.....

I was thinking exactly the same thing ..

> this patch ought to make it do that; could you at least add this to your
> kernel?

I'll add the patch, but I doubt I'll see it again ..

Daniel

