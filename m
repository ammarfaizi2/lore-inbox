Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUFPO5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUFPO5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUFPO5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:57:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:62437 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263980AbUFPO5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:57:04 -0400
Date: Wed, 16 Jun 2004 16:56:09 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7
In-Reply-To: <40CFEFAD.2060207@ThinRope.net>
Message-ID: <Pine.LNX.4.56.0406161649330.10708@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
 <40CFEFAD.2060207@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Kalin KOZHUHAROV wrote:

> When I unpack linux sources (`tar xjvf linux-${KV}.tar.bz2`), I usually do that in /usr/src/ and do it as root the first time.

Why?

Why not just do the sane thing and unpack the tarball as a normal user (in
your homedir) configure as normal user, build as normal user, install as root

Have you ever read this btw? :
http://www.linuxmafia.com/faq/Kernel/usr-src-linux-symlink.html


--
Jesper Juhl <juhl-lkml@dif.dk>
