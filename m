Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272249AbTGaBGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 21:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTGaBGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 21:06:41 -0400
Received: from zok.SGI.COM ([204.94.215.101]:41185 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S272249AbTGaBGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 21:06:41 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules. 
In-reply-to: Your message of "Thu, 31 Jul 2003 02:46:23 +1000."
             <20030730183635.0B82D2C097@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jul 2003 11:06:35 +1000
Message-ID: <2347.1059613595@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 02:46:23 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>I don't want to require zlib, though.  The modutils I have (Debian)
>doesn't support it, either.

Really?  modutils 2.4: ./configure --enable-zlib

