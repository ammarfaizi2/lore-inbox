Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUGNTHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUGNTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUGNTGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:06:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:47322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265211AbUGNTGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:06:12 -0400
Date: Wed, 14 Jul 2004 12:03:25 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Luca Risolia <luca.risolia@studio.unibo.it>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.6.8-rc1-mm1: USB w9968cf compile error
Message-ID: <20040714190325.GB28501@kroah.com>
References: <20040713182559.7534e46d.akpm@osdl.org> <20040714184953.GI7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714184953.GI7308@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 08:49:53PM +0200, Adrian Bunk wrote:
> On Tue, Jul 13, 2004 at 06:25:59PM -0700, Andrew Morton wrote:
> >...
> > All 252 patches:
> >...
> > bk-usb.patch
> >...
> 
> This patch marks w9968cf_valid_depth as inline, although it's used 
> before it's defined.

Looks good, applied, thanks.

greg k-h
