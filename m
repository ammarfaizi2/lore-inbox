Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTKKIy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTKKIy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:54:29 -0500
Received: from mail.enyo.de ([212.9.189.167]:27661 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263441AbTKKIy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:54:28 -0500
Date: Tue, 11 Nov 2003 09:54:26 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
Message-ID: <20031111085426.GA11435@deneb.enyo.de>
References: <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au> <Pine.LNX.4.44.0311101613440.2881-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311101613440.2881-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> What compiler versions do you have installed on the broken vs good
> machines?

GCC 3.3.2 (Debian 3.3.2-3) is broken for me (binutils is 2.14.89.0.7-2).

Which compiler is recommend/known to work?  The README file mentions GCC
2.95.3, but this one has problems as well, AFAIK.
