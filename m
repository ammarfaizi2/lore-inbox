Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272444AbTG3R5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272835AbTG3R5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:57:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:37042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272444AbTG3R5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:57:04 -0400
Date: Wed, 30 Jul 2003 10:56:49 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile AX8817x driver
Message-ID: <20030730175648.GA2333@kroah.com>
References: <yw1xsmp0f4zh.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsmp0f4zh.fsf@zaphod.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 02:18:10PM +0200, Måns Rullgård wrote:
> 
> This trivial Makefile patch causes the AX8817x driver to actually be
> built.  The diff is against 2.6.0-test1.

Applied, thanks.

greg k-h
