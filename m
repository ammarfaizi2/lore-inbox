Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUIIS3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUIIS3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUIIS2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:28:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:61079 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266538AbUIISWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:22:22 -0400
Subject: Re: 10 New compile/sparse warnings (overnight build)
From: John Cherry <cherry@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909172921.GB19843@redhat.com>
References: <1094741838.4142.6.camel@cherrybomb.pdx.osdl.net>
	 <1094747967.2468.35.camel@cherrybomb.pdx.osdl.net>
	 <20040909172921.GB19843@redhat.com>
Content-Type: text/plain
Message-Id: <1094754133.6867.51.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Sep 2004 11:22:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse binary is being updated every two weeks.  I am trying to
avoid mining reasonable data with a changing kernel AND a changing
sparse tool.

John

On Thu, 2004-09-09 at 10:29, Dave Jones wrote:
> On Thu, Sep 09, 2004 at 09:39:27AM -0700, John Cherry wrote:
>  > Sorry about the duplicate entries.  I'll fix the tool.  There are really
>  > just 7 new sparse warnings.
> 
> Out of curiosity, how often is the sparse binary being updated
> in this automated check ?
> 
> 		Dave

