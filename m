Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUE1OEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUE1OEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUE1OEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:04:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45696 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263124AbUE1OEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:04:39 -0400
Date: Fri, 28 May 2004 18:04:38 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Thomas Steudten <alpha@steudten.com>
Cc: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: Kernel crash/ oops >= 2.6.5 with gcc 3.4.0 on alpha
Message-ID: <20040528180438.A1076@jurassic.park.msu.ru>
References: <40B726C0.5030400@steudten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40B726C0.5030400@steudten.com>; from alpha@steudten.com on Fri, May 28, 2004 at 01:47:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 01:47:12PM +0200, Thomas Steudten wrote:
> No other application seems to fail with gcc-3.4.0 so I think
> this problem is in context to the relocation, modules and gcc-3.4.0.

Correct. It's fixed in 2.6.7-rc1.

Ivan.
