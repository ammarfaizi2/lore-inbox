Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUFDPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUFDPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUFDPgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:36:09 -0400
Received: from pop.gmx.net ([213.165.64.20]:23483 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265812AbUFDPgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:36:06 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.7-rc2-mm2
Date: Fri, 4 Jun 2004 17:46:16 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0406041047080.2279-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0406041047080.2279-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406041746.17925.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 16:48, Alan Stern wrote:
> On Fri, 4 Jun 2004, Andrew Morton wrote:
> > Guys, the USB bk tree as of 24 hours ago causes Dominik's
> > machine to hang during boot.
>
> The problem might be this patch, which was removed by Greg yesterday:
>
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108595019132692&w=2
>
> Alan Stern

Yes, I removed that patch from the bk-usb.patch and it works now for me too.

greets dominik
