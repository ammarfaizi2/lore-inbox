Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264414AbTCXSRF>; Mon, 24 Mar 2003 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbTCXSRF>; Mon, 24 Mar 2003 13:17:05 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:19074 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264414AbTCXSRE>; Mon, 24 Mar 2003 13:17:04 -0500
Date: Mon, 24 Mar 2003 18:28:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: henrique.gobbi@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cyclades region handling updates from 2.4
Message-ID: <20030324182802.GC8300@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	henrique.gobbi@cyclades.com, linux-kernel@vger.kernel.org
References: <200303241641.h2OGft35008188@deviant.impure.org.uk> <3E7ED5F6.9090301@cyclades.com> <20030324180211.GA8300@suse.de> <3E7ED9DF.5020909@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7ED9DF.5020909@cyclades.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linus taken out of cc>

On Mon, Mar 24, 2003 at 10:11:43AM +0000, Henrique Gobbi wrote:

 > >if you have customers depending on 2.5 right now, you have bigger problems.
 > >Note this is only stuff that has already been merged into 2.4
 > 
 > No, there's no customers using 2.5. But there's a lot of them using 2.4. 
 >  Let's do like this. I'll test your patch and, if it works, Marcelo can 
 > merge it into the oficial 2.4.x tree.

I think you've completley misunderstood whats going on.
This patch _already_ went into 2.4
I've forward ported the fixes to 2.5, and sent these on.
There is nothing to do here for 2.4

		Dave

