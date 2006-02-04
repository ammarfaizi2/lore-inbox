Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWBDVLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWBDVLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 16:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBDVLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 16:11:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33443 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932573AbWBDVLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 16:11:39 -0500
Date: Sat, 4 Feb 2006 22:11:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060204211126.GG3909@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz> <20060128013111.GA30225@srcf.ucam.org> <20060128084225.GC1605@elf.ucw.cz> <20060129071239.GB23736@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129071239.GB23736@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks for pointer! Anyway, AFAICT the list is not really adequate. It
> > lists working machines, but does not really list all the switches
> > neccessary to get the video working. (Well, it tries in some cases,
> > *strange*, perhaps less switches are neccessary than I think?)
> 
> For machines where nothing is listed, we do POSTing and restore the VBE 
> state. These may not be necessary in all cases, but they don't seem to 
> be actively harmful except on the machines where they're explicitly 
> switched of.f

Ahha, nice. vbetool seems to work on very wide range of machines.
								Pavel
-- 
Thanks, Sharp!
