Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVAXUys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVAXUys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVAXUyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:54:38 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:28380 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261653AbVAXUwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:52:11 -0500
Date: Tue, 25 Jan 2005 00:10:47 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050125001047.1fc256ed@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050124203353.GA5048@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124203353.GA5048@infradead.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 20:33:53 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 24, 2005 at 06:54:49PM +0100, Adrian Bunk wrote:
> > It seems noone who reviewed the SuperIO patches noticed that there are 
> > now two modules "scx200" in the kernel...
> 
> Did anyone review them?

As I said it is completely my fault, I pressed on Greg, 
since patch several month laid after testing and people often asked
about GPIO in various SuperIO chips.

Patches were sent into lm_sensors@ mail list some time ago 
and code itself did not meet any objections.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
