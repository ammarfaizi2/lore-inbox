Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUHHTD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUHHTD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUHHTD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:03:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:31287 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266186AbUHHTDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:03:15 -0400
Date: Sun, 8 Aug 2004 21:05:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040808190508.GD22610@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org,
	zippel@linux-m68k.org
References: <20040803225753.15220897.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803225753.15220897.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:57:53PM -0700, Randy.Dunlap wrote:
> 
> (from June/2004 email thread:
> http://marc.theaimsgroup.com/?t=108753573200001&r=1&w=2
> )
> 
> Several people found this useful, none opposed (afaik).
> 
> Saves kernel version in .config file, e.g.:
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.8-rc3
> # Tue Aug  3 22:55:57 2004
> #
> 
> Please merge.

Applied - thanks.

	Sam
