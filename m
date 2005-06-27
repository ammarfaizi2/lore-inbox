Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVF0UyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVF0UyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0Uvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:51:54 -0400
Received: from waste.org ([216.27.176.166]:1703 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261689AbVF0UvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:51:18 -0400
Date: Mon, 27 Jun 2005 13:51:12 -0700
From: Matt Mackall <mpm@selenic.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050627205112.GP12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050627183118.GB1415@elf.ucw.cz> <20050627194031.GK12006@waste.org> <20050627195134.GA17107@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627195134.GA17107@kvack.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:51:34PM -0400, Benjamin LaHaise wrote:
> On Mon, Jun 27, 2005 at 12:40:31PM -0700, Matt Mackall wrote:
> >  $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc
> 
> This needs to be ${HOME}/lib64/python on x86-64.

Thanks, I'll add this to the README.

-- 
Mathematics is the supreme nostalgia of our time.
