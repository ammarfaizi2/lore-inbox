Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUAUBgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUAUBgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:36:42 -0500
Received: from [24.35.117.106] ([24.35.117.106]:59270 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265754AbUAUBgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:36:32 -0500
Date: Tue, 20 Jan 2004 20:36:24 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5
In-Reply-To: <20040120163452.3f407cbd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401202034440.9398@localhost.localdomain>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
 <20040120163452.3f407cbd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jan 2004, Andrew Morton wrote:

> Do you have
> 
> 	alias char-major-162 raw
> 
> in /etc/modprobe.conf?
> 
> If you do, touching /dev/rawctl does indeed corretly autoload the module,
> but it seems that script still complains for some reason.

You asked this for mm4.  I added that line and it didn't help.  Sorry.
