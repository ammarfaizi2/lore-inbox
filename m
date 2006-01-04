Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbWADTBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWADTBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWADTBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:01:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26828 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965273AbWADTBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:01:41 -0500
Date: Wed, 4 Jan 2006 13:01:30 -0600
From: Robin Holt <holt@sgi.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20060104190130.GA20175@lnx-holt.americas.sgi.com>
References: <20060103132035.GA17485@mars.ravnborg.org> <11362947262643@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11362947262643@foobar.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

I just finally got caught up from vacation and noticed that you do
not have a patch which rebuilds keywords.c_shipped, lex.c_shipped,
parse.c_shipped, parse.h_shipped.  Did I miss a patch in this set?

Thanks,
Robin
