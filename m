Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTCYBNg>; Mon, 24 Mar 2003 20:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCYBNg>; Mon, 24 Mar 2003 20:13:36 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:61334 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261316AbTCYBNg>; Mon, 24 Mar 2003 20:13:36 -0500
Date: Tue, 25 Mar 2003 01:24:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: conntrack related slab corruption in 2.5.65
Message-ID: <20030325012428.GA8048@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Martin Josefsson <gandalf@wlug.westbo.se>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030324220404.GB3034@suse.de> <1048545120.14720.45.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048545120.14720.45.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 11:32:01PM +0100, Martin Josefsson wrote:

 > Are you using a conntrack helper (ie. ip_conntrack_ftp) ?
 > If so then this is fixed in -mm. If not then this is another bug that I
 > need to track down.

Yep, I was. Thanks for the patch, I'll give it a spin.

		Dave

