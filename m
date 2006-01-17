Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWAQA5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWAQA5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWAQA5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:57:53 -0500
Received: from [218.25.172.144] ([218.25.172.144]:19473 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751294AbWAQA5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:57:52 -0500
Date: Tue, 17 Jan 2006 08:57:45 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: abandon gcc 295x main.c tidy
Message-ID: <20060117005745.GA3022@localhost.localdomain>
References: <20060113035156.GA5665@localhost.localdomain> <200601150427.k0F4R0CO004743@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601150427.k0F4R0CO004743@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:27:00AM -0300, Horst von Brand wrote:
> Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> > After abandon-gcc-295x.patch, this relocates the
> > error-out-early comment.
> 
> What for?

It looks like this now:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=69c99ac17e2ee0eb45e2c9873e6e12d73260fc6b

Also read abandon-gcc-295x.patch to see what for.
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/abandon-gcc-295x.patch
-- 
Coywolf Qi Hunt
