Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947364AbWKLAsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947364AbWKLAsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947375AbWKLAsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 19:48:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1947364AbWKLAsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 19:48:10 -0500
Date: Sat, 11 Nov 2006 16:47:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Greg KH <gregkh@suse.de>, "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>,
       Daniel Paschka <monkey20181@gmx.net>, Adrian Bunk <bunk@susta.de>
Subject: Re: [PATCH] fix via586 irq routing for pirq 5
Message-Id: <20061111164757.553574c2.akpm@osdl.org>
In-Reply-To: <200611120052.45485.daniel.ritz-ml@swissonline.ch>
References: <200611120052.45485.daniel.ritz-ml@swissonline.ch>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 00:52:44 +0100
Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:

> ( for 2.6.19, and i think it would be good for -stable too... )

Yup.

> [PATCH] fix via586 irq routing for pirq 5

Thanks very much for working this one out.  Most impressive.
