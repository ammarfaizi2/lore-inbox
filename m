Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTHDKQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271698AbTHDKQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 06:16:33 -0400
Received: from [195.206.1.27] ([195.206.1.27]:10001 "EHLO spidernet.it")
	by vger.kernel.org with ESMTP id S271696AbTHDKQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 06:16:31 -0400
Date: Mon, 4 Aug 2003 12:17:09 +0200
From: adri <adriano.archetti@tiscali.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030804101709.GA4797@inwind.it>
Mail-Followup-To: adri <adriano.archetti@tiscali.it>,
	linux-kernel@vger.kernel.org
References: <20030728214523.GA485@inwind.it> <20030729142025.GA2180@win.tue.nl> <20030730072708.GA893@inwind.it> <20030802223740.GA655@inwind.it> <20030804095310.GA4420@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804095310.GA4420@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

il giorno Mon, Aug 04, 2003 at 11:53:10AM +0200, Andries Brouwer ha scritto
> Yes, thanks for confirming. The new input code generates the repeat
> synthetically, by setting a timer, and that code must be buggy.
ok, thanks for your answer...
have you any idea of where to search and playing with that time to try
to find the bug?
btw, i'm always here to test... ;))
adri
-- 
icq# 63011800 - jabber: adri@jabber.org
gnupg key id: 4472FB13
"Non esiste vento favorevole per il marinaio che non sa dove andare."
Seneca
