Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbUKDAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUKDAou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUKDAmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:42:40 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:20624 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262018AbUKDAhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:37:53 -0500
Date: Wed, 3 Nov 2004 16:37:34 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041104003734.GA17467@taniwha.stupidest.org>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com> <20041104002138.GA32691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104002138.GA32691@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:21:39PM -0800, Greg KH wrote:

> Due to the change in the way the function works, I'm slowly changing
> drivers over to the new function.  It's just too dangerous over time
> to leave it alone.

this is what i'm not clear about --- how does it work differently?
