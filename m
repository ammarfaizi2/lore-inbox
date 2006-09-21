Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWIUKqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWIUKqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWIUKqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:46:35 -0400
Received: from thunk.org ([69.25.196.29]:30384 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750800AbWIUKqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:46:34 -0400
Date: Thu, 21 Sep 2006 06:45:54 -0400
From: Theodore Tso <tytso@mit.edu>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/char/random.c exported interfaces
Message-ID: <20060921104554.GA12542@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dmitry Torokhov <dtor@insightbb.com>,
	Robin Getz <rgetz@blackfin.uclinux.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com> <200609210011.25891.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609210011.25891.dtor@insightbb.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:11:25AM -0400, Dmitry Torokhov wrote:
> Would there be any objections if I commit the patch below so input
> could be built as a module? 
> 
> -- 
> Dmitry
> 
> Input: fix building input core as a module
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: "Theodore Ts'o" <tytso@mit.edu>

						- Ted
