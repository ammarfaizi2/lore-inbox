Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVFAFIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFAFIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFAFH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:07:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:37523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261261AbVFAFF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:05:56 -0400
Date: Tue, 31 May 2005 22:04:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
Message-Id: <20050531220449.1dc15eb4.akpm@osdl.org>
In-Reply-To: <429CECE3.1060904@tls.msk.ru>
References: <429CECE3.1060904@tls.msk.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> I noticied that parport_pc and 8250[_pnp] modules
>  can't be re-loaded without rebooting when PNP is
>  turned on in kernel config.  Here's how it looks
>  like:

Please test 2.6.12-rc5
