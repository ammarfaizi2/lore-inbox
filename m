Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031675AbWLABNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031675AbWLABNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031688AbWLABNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:13:23 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33489
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031675AbWLABNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:13:22 -0500
Date: Thu, 30 Nov 2006 17:13:24 -0800 (PST)
Message-Id: <20061130.171324.86891944.davem@davemloft.net>
To: burman.yan@gmail.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sparc64: replace kmalloc+memset with kzalloc
From: David Miller <davem@davemloft.net>
In-Reply-To: <4566DF79.6030004@gmail.com>
References: <4566DF79.6030004@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Burman <burman.yan@gmail.com>
Date: Fri, 24 Nov 2006 14:03:05 +0200

> Replace kmalloc+memset with kzalloc 
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>

Applied, thanks Yan.

