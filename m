Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWDZVXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWDZVXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWDZVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:23:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:26058 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964875AbWDZVXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:23:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Date: Wed, 26 Apr 2006 23:23:37 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060422221232.GA6269@uio.no> <200604262259.39691.rjw@sisk.pl> <20060426210124.GA15619@uio.no>
In-Reply-To: <20060426210124.GA15619@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604262323.38463.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 23:01, Steinar H. Gunderson wrote:
> On Wed, Apr 26, 2006 at 10:59:39PM +0200, Rafael J. Wysocki wrote:
> > This kind of agrees with my result ie. list_del() in isolate_lru_pages():
> 
> Well, look at the followup -- I'm not convinced the address lookup is right.

Beats me. :-(

Rafael
