Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbVGOUoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbVGOUoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGOUoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:44:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263368AbVGOUnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:43:51 -0400
Subject: Re: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050715203632.GD18059@stusta.de>
References: <20050715203632.GD18059@stusta.de>
Content-Type: text/plain
Organization: Red Hat
Date: Fri, 15 Jul 2005 15:43:31 -0500
Message-Id: <1121460211.2755.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 22:36 +0200, Adrian Bunk wrote:
> I can't see any effect of this option outside the i386-specific APM 
> code.

Doesn't the Javastation potentially use this?

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

