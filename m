Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWD0M56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWD0M56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWD0M56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:57:58 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58800 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965026AbWD0M55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:57:57 -0400
Date: Thu, 27 Apr 2006 16:57:45 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] W1_CON: add W1 to depends
Message-ID: <20060427125745.GA12840@2ka.mipt.ru>
References: <20060426212131.1c566d19.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060426212131.1c566d19.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 27 Apr 2006 16:57:45 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 09:21:31PM -0700, Randy.Dunlap (rdunlap@xenotime.net) wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> W1_CON should depend on W1 also.

I have no problem with the patch, but does dependency absence introduce
some problems? This config option is only used when w1 is enabled.

-- 
	Evgeniy Polyakov
