Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTG3Ufc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272239AbTG3Ufb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:35:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:12760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272234AbTG3Uf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:35:27 -0400
Date: Wed, 30 Jul 2003 13:15:22 -0700
From: Greg KH <greg@kroah.com>
To: Joilnen Leite <knl_joi@yahoo.com.br>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: bep poiner
Message-ID: <20030730201522.GH4565@kroah.com>
References: <20030725004151.75512.qmail@web40312.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725004151.75512.qmail@web40312.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 09:41:51PM -0300, Joilnen Leite wrote:
> Excuse me friends if I am simpler but,
> in auerbuf_setup function bep pointer is not free, I
> guess
> maybe it is better ?

Thanks, I've applied this fix.

greg k-h
