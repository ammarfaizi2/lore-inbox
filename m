Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLUBUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTLUBUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:20:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:43932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261973AbTLUBUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:20:11 -0500
Date: Sat, 20 Dec 2003 17:19:54 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Ga=EBl?= Deest <GUtopiste@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while unloading module
Message-ID: <20031221011954.GA3507@kroah.com>
References: <3FE43FD9.3010509@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FE43FD9.3010509@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 01:26:01PM +0100, Gaël Deest wrote:
> I first apologize for my approximative english.
> 
> I will soon get a Logitech Quickcam pro 4000, so I compiled my kernel 
> with the PWC driver for Philips webcams (built-in). In addition, I tried 
> to load the external (and closed-source) pwcx module (without the webcam 
> plugged-in, of course). When I wanted to unload it with rmmod, it ended 
> with "Segmentation fault" and I got the following Oops :

You'll have to ask the pwcx driver author about this, sorry.

greg k-h
