Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVEZQhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVEZQhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEZQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:37:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36549 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261601AbVEZQhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:37:31 -0400
Subject: Re: getting eth1: Memory squeeze, dropping packet message
From: Lee Revell <rlrevell@joe-job.com>
To: cranium2003 <cranium2003@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050526143926.69208.qmail@web33010.mail.mud.yahoo.com>
References: <20050526143926.69208.qmail@web33010.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 12:37:23 -0400
Message-Id: <1117125443.6261.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 07:39 -0700, cranium2003 wrote:
> Hello,
>        While transmitting packets through linux Router
> host from one network to another Redhat linux 9 kernel
> 2.4.20-8 caught kernel oops following there are 2
> statements which are
> __alloc_pages: 0 order allocation failed (gfp =
> 0x20/1)
> eth1: Memory squeeze, dropping packet
> What this means? where is the wrong thing in kenrel?
> How to solve this problem?

That just means you ran low on memory so the router dropped a packet.
Get more RAM, or handle fewer packets ;-)

Lee

