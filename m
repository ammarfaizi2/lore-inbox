Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUIXNHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUIXNHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUIXNHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:07:40 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:10669 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S268729AbUIXNHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:07:39 -0400
Date: Fri, 24 Sep 2004 15:07:38 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'David S. Miller'" <davem@davemloft.net>,
       "'Jeff Garzik'" <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk,
       paul@clubi.ie, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-ID: <20040924130738.GB24093@xi.wantstofly.org>
References: <20040915142926.7bc456a4.davem@davemloft.net> <200409152329.i8FNTsqG025184@guinness.s2io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409152329.i8FNTsqG025184@guinness.s2io.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:29:45PM -0700, Leonid Grossman wrote:

> And at 10GbE, embedded CPUs just don't cut it - it has to be custom ASIC
> (granted, with some means to simplify debugging and reduce the risk of hw
> bugs and TCP changes).

Intel's IXP2800 can do 10GbE.

http://www.intel.com/design/network/products/npfamily/ixp2800.htm


--L
