Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVGGJ7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVGGJ7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVGGJ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:59:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:20375 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261271AbVGGJ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:59:43 -0400
Date: Thu, 7 Jul 2005 13:59:28 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Tero Roponen <teanropo@cc.jyu.fi>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050707135928.A3314@jurassic.park.msu.ru>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi> <9e47339105070618273dfb6ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e47339105070618273dfb6ff8@mail.gmail.com>; from jonsmirl@gmail.com on Wed, Jul 06, 2005 at 09:27:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:27:11PM -0400, Jon Smirl wrote:
> I'm dead on a Dell PE400SC without reverting this.

Jon, can you try this one instead:
http://lkml.org/lkml/2005/7/6/273

If it doesn't help, I'd like to see 'lspci -vv' from your machine.

Ivan.
