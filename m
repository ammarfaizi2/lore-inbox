Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVBMQ4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVBMQ4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVBMQ4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:56:40 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:29086 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261182AbVBMQ4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:56:38 -0500
Date: Sun, 13 Feb 2005 14:56:27 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050213165627.GA5978@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br> <20050212232134.GA2242@node1.opengeometry.net> <20050212235043.GA4291@ime.usp.br> <20050213014151.GA2735@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050213014151.GA2735@node1.opengeometry.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12 2005, William Park wrote:
> Do you have MSI on by any chance?  (CONFIG_PCI_MSI)  If so, try kernel
> without it.  My motherboard exhibits runaway IRQ with it.

Ok, now I've just downloaded the -rc4 patch and while selecting the options
to compile, I saw what MSI means. No, I didn't have MSI enabled.

I guess tha I could try a compile with it enabled? I enabled the ACPI
debugging messages, just in case it helps.

I will now compile the new kernel. Let's see if the debugging messages help
here.


Hope this information is useful, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
