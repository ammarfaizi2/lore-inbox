Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWGMHer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWGMHer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWGMHer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:34:47 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:45496 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751474AbWGMHeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:34:46 -0400
Message-ID: <44B5F793.1000100@namesys.com>
Date: Thu, 13 Jul 2006 00:34:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jeffm@suse.com, reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <44B52674.8060802@suse.com>	<20060712175542.108e6e37.akpm@osdl.org>	<44B5C353.9060007@namesys.com> <20060712210027.8d7a2ddc.akpm@osdl.org>
In-Reply-To: <20060712210027.8d7a2ddc.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who exactly is failing to handle the slashes, forgive me for my
confusion in asking?

Hans

Andrew Morton wrote:

> Software sucks, and we get along better by not provoking it. So don't put
>
>spaces, let alone slashes into strings which we offer to userspace.
>
>
>  
>

