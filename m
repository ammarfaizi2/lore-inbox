Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWDXI1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDXI1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWDXI1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:27:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:63150 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751162AbWDXI1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:27:42 -0400
Date: Mon, 24 Apr 2006 10:28:31 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424082831.GI440@marowsky-bree.de>
References: <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz> <444AF977.5050201@novell.com> <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu> <20060423145846.GA7495@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060423145846.GA7495@thorium.jmh.mhn.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-23T16:58:47, Thomas Bleher <bleher@informatik.uni-muenchen.de> wrote:

> Later, the admin decides to save space, deletes the bin/ directory and
> instead links /bin/ls into the chroot. Suddenly the system is easily
> exploitable.

Security models can be compromised by root or by dumb accomplices. Film
at eleven.

Seriously, this is not helpful. Could we instead focus on the technical
argument wrt the kernel patches?

