Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWHXRzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWHXRzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWHXRzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:55:32 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49811 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751481AbWHXRzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:55:31 -0400
Date: Thu, 24 Aug 2006 19:59:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Adrian Bunk <bunk@stusta.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824175922.GA22586@uranus.ravnborg.org>
References: <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org> <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru> <20060824170709.GO19810@stusta.de> <1156439763.3012.155.camel@pmac.infradead.org> <20060824103459.77e5569c.rdunlap@xenotime.net> <1156441724.3012.183.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156441724.3012.183.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:48:44PM +0100, David Woodhouse wrote:
> Finding the brain-damaged 'select' which is preventing me from turning a
> given option _off_, however, is something I tend to find far more
> difficult. The CONFIG_EMBEDDED crap took up a painful amount of my time
> last week when it bit me too.

Here meuconfig can be a great help for you. Trying the help option
tells you a bit more about what needs to be done to disable
a given option.

	Sam
