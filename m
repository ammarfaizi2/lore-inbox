Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272008AbTHHVfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTHHVfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 17:35:23 -0400
Received: from holomorphy.com ([66.224.33.161]:13468 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272008AbTHHVfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 17:35:19 -0400
Date: Fri, 8 Aug 2003 14:36:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <20030808213613.GC32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0308071905200.5090-100000@logos.cnet> <Pine.LNX.4.44.0308081749470.10734-300000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081749470.10734-300000@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 05:51:07PM -0300, Marcelo Tosatti wrote:
> William, Andrew,
> Attached are the full boot messages before the crash plus lspci -vvv 
> output.
> PXELINUX 1.62 2001-04-24  Copyright (C) 1994-2001 H. Peter Anvin
> boot: 
> Booting from local disk...

What happens near or around the reported point of failure with
initcall_debug on?


-- wli
