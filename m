Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946013AbWJaVQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbWJaVQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbWJaVQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:16:50 -0500
Received: from mail.suse.de ([195.135.220.2]:30646 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946010AbWJaVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:16:49 -0500
Date: Tue, 31 Oct 2006 13:16:15 -0800
From: Greg KH <gregkh@suse.de>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md array starts/stops.
Message-ID: <20061031211615.GC21597@suse.de>
References: <20061031164814.4884.patches@notabene> <1061031060046.5034@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061031060046.5034@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:00:46PM +1100, NeilBrown wrote:
> 
> This allows udev to do something intelligent when an
> array becomes available.
> 
> cc: gregkh@suse.de
> Signed-off-by: Neil Brown <neilb@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
