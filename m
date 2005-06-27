Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVF0TyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVF0TyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVF0Tul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:50:41 -0400
Received: from kanga.kvack.org ([66.96.29.28]:52645 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261328AbVF0TuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:50:10 -0400
Date: Mon, 27 Jun 2005 15:51:34 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050627195134.GA17107@kvack.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050627183118.GB1415@elf.ucw.cz> <20050627194031.GK12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627194031.GK12006@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 12:40:31PM -0700, Matt Mackall wrote:
>  $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc

This needs to be ${HOME}/lib64/python on x86-64.

		-ben
