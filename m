Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272793AbTG3H0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272794AbTG3H0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:26:30 -0400
Received: from [195.206.1.27] ([195.206.1.27]:62987 "EHLO spidernet.it")
	by vger.kernel.org with ESMTP id S272793AbTG3H03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:26:29 -0400
Date: Wed, 30 Jul 2003 09:27:08 +0200
From: adri <adriano.archetti@tiscali.it>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030730072708.GA893@inwind.it>
Mail-Followup-To: adri <adriano.archetti@tiscali.it>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <20030728214523.GA485@inwind.it> <20030729142025.GA2180@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729142025.GA2180@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

il giorno Tue, Jul 29, 2003 at 04:20:25PM +0200, Andries Brouwer ha scritto
> Could you compile i8042.c with #define DEBUG instead of #undef DEBUG
> and report what that yields in the syslog?
yes, because the very long report, i prefer to put it in:
http://www.archetti.org/syslog

I also read about some keyboard failure dues at the new kernel, so i'm
still tring using patch i see in lkml.

many thanks for your interesting, i hope to easy solve the problem ;))

adri
-- 
icq# 63011800 - jabber: adri@jabber.org
gnupg key id: 4472FB13
"Non esiste vento favorevole per il marinaio che non sa dove andare."
Seneca
