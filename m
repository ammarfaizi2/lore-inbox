Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVAaO1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVAaO1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVAaO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:27:12 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:40134 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261215AbVAaO02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:26:28 -0500
Date: Mon, 31 Jan 2005 15:26:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050131142634.GC6694@wohnheim.fh-wedel.de>
References: <20050130180016.GA12987@infradead.org> <1107132112.783.219.camel@baythorne.infradead.org> <1107159869.4221.53.camel@laptopd505.fenrus.org> <20050131135631.GA6694@wohnheim.fh-wedel.de> <20050131140104.GK18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050131140104.GK18316@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 January 2005 15:01:04 +0100, Adrian Bunk wrote:
> 
> Your patch doesn't add a Kconfig entry for INTER_MODULE_CRAP.

True.  But where to add it?  arch/*/Kconfig is pretty ugly.
drivers/mtd/Kconfig?

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
