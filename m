Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263402AbTC2Kvy>; Sat, 29 Mar 2003 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbTC2Kvy>; Sat, 29 Mar 2003 05:51:54 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:37299 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263402AbTC2Kvx>; Sat, 29 Mar 2003 05:51:53 -0500
Date: Sat, 29 Mar 2003 11:02:51 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xircom init_etherdev conversion.
Message-ID: <20030329110244.GA30863@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <200303241642.h2OGg335008252@deviant.impure.org.uk> <3E852901.7000903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E852901.7000903@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29, 2003 at 12:02:57AM -0500, Jeff Garzik wrote:
 > davej@codemonkey.org.uk wrote:
 > >- Also cleans up some exit paths.
 > 
 > ...and now xircom_remove is kfree'ing memory that was never kmalloc'd

Which one ? I don't see it..

		Dave
