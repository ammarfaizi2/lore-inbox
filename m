Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbTLHPnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTLHPnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:43:55 -0500
Received: from holomorphy.com ([199.26.172.102]:41179 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265445AbTLHPnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:43:04 -0500
Date: Mon, 8 Dec 2003 07:42:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031208154256.GV19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <200312081536.26022.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312081536.26022.andrew@walrond.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
> Whats the general feeling about devfs now? I remember Christoph and others 
> making some nasty remarks about it 6months ago or so, but later noted 
> christoph doing some slashing and burning thereof.
> Is it 'nice' yet? 
> Andrew Walrond

I would say it's deprecated at the very least. sysfs and udev are
supposed to provide equivalent functionality, albeit by a somewhat
different mechanism.


-- wli
