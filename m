Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272647AbTG3R5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272835AbTG3R5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:57:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:37554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272647AbTG3R5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:57:05 -0400
Date: Wed, 30 Jul 2003 10:57:06 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AX8817x (USB ethernet) problem in 2.6.0-test1
Message-ID: <20030730175706.GB2333@kroah.com>
References: <yw1x1xwkgm6z.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x1xwkgm6z.fsf@zaphod.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:21:08PM +0200, Måns Rullgård wrote:
> 
> My Netgear FA120 USB2 ethernet adaptor isn't working properly with
> Linux 2.6.0-test1.  First off, I had to modify it slightly (patch
> below) to make it work at all with USB2.

Applied, thanks.

greg k-h
