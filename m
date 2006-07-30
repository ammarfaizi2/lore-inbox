Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWG3WTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWG3WTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWG3WTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:19:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58522 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751393AbWG3WTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:19:19 -0400
Date: Mon, 31 Jul 2006 00:19:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
In-Reply-To: <200607301442.07426.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0607310011180.6761@scrub.home>
References: <20060727202726.GA3900@mars.ravnborg.org>
 <Pine.LNX.4.64.0607281348420.6761@scrub.home> <20060728145947.GA29095@mars.ravnborg.org>
 <200607301442.07426.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 30 Jul 2006, Denis Vlasenko wrote:

> I don't like "double ESC" idea at all.
> 
> I am a Midnight Commander user and I use "old ESC mode"
> where single ESC works after a delay.

As you noticed this is not the default mode in mc either.

> I patched mc to look at KEYBOARD_KEY_TIMEOUT_US environment variable 
> so that delay is configurable (instead of hardcoded 0.5 second one).
> Will push the patch to mc-devel.

If you want to make it an _option_ for menuconfig, please go ahead.

bye, Roman
