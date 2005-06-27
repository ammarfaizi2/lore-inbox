Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVF0FVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVF0FVC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVF0FVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:21:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:58756 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261822AbVF0FU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:20:57 -0400
Subject: Re: kbuild warnings with current git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050626.215216.07640230.davem@davemloft.net>
References: <1119846670.5133.101.camel@gaston>
	 <20050626.215216.07640230.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 15:16:05 +1000
Message-Id: <1119849366.5133.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-26 at 21:52 -0700, David S. Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Subject: kbuild warnings with current git
> Date: Mon, 27 Jun 2005 14:31:09 +1000
> 
> > net/ipv4/Kconfig:551:warning: type of 'TCP_CONG_BIC' redefined from 'tristate' to 'boolean'
> > 
> > net/ipv4/Kconfig:92:warning: defaults for choice values not supported
> 
> I sent Linus a fix for this an hour ago, it is in his
> GIT tree right now.

Ah ok, missed it,

Thanks.

Ben.

