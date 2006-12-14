Return-Path: <linux-kernel-owner+w=401wt.eu-S1751971AbWLNXZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWLNXZa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWLNXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:25:30 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37947
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751958AbWLNXZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:25:29 -0500
Date: Thu, 14 Dec 2006 15:25:09 -0800 (PST)
Message-Id: <20061214.152509.56812108.davem@davemloft.net>
To: mchan@broadcom.com
Cc: burman.yan@gmail.com, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.19] tg3: replace kmalloc+memset with kzalloc
From: David Miller <davem@davemloft.net>
In-Reply-To: <1165955428.3505.1.camel@rh4>
References: <1165950654.10231.5.camel@localhost>
	<1165955428.3505.1.camel@rh4>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Tue, 12 Dec 2006 12:30:28 -0800

> On Tue, 2006-12-12 at 21:10 +0200, Yan Burman wrote:
> > Replace kmalloc+memset with kzalloc
> > 
> > Signed-off-by: Yan Burman <burman.yan@gmail.com>
> 
> Acked-by: Michael Chan <mchan@broadcom.com>

Applied, thanks everyone.
