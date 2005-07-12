Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVGLQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVGLQLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGLQJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:09:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16044 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261548AbVGLQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:08:05 -0400
Date: Tue, 12 Jul 2005 20:07:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tero Roponen <teanropo@cc.jyu.fi>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, gregkh@suse.de, jonsmirl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
Message-ID: <20050712200742.A13716@jurassic.park.msu.ru>
References: <200507081354.j68Ds02b020296@harpo.it.uu.se> <20050712174119.A31613@jurassic.park.msu.ru> <Pine.GSO.4.58.0507121856050.27617@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.58.0507121856050.27617@tukki.cc.jyu.fi>; from teanropo@cc.jyu.fi on Tue, Jul 12, 2005 at 07:00:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 07:00:37PM +0300, Tero Roponen wrote:
> It seems that everything is fine until some module
> loads and does something.

What does your /proc/ioports say under 2.6.12 with all modules
loaded?

Ivan.
