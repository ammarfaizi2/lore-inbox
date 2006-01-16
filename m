Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWAPOYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWAPOYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWAPOYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:24:13 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:13115 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750828AbWAPOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:24:12 -0500
Date: Mon, 16 Jan 2006 23:24:14 +0900
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] makes print_symbol() return int
Message-ID: <20060116142414.GA6836@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <20060116121706.GB539@miraclelinux.com> <9a8748490601160616i35fa2a6fv693d8ecc84133d5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601160616i35fa2a6fv693d8ecc84133d5f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 03:16:36PM +0100, Jesper Juhl wrote:
> On 1/16/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> > This patch makes print_symbol() return the number of characters printed.
> >
> Why?
> Who are the users of this?
> If there are users who can bennefit, then where's the patch to make
> them use this new return value?

Please see 2/3
