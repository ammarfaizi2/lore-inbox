Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbUDNLr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 07:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbUDNLr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 07:47:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16838
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264062AbUDNLr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 07:47:28 -0400
Date: Wed, 14 Apr 2004 13:47:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: admin@list.net.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!
Message-ID: <20040414114731.GJ2150@dualathlon.random>
References: <200404141257.16731.gluk@php4.ru> <20040414095435.GH2150@dualathlon.random> <200404141539.49757.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404141539.49757.gluk@php4.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 03:39:49PM +0400, Alexander Y. Fomichev wrote:
> exactly right, apache2 compiled --with-mpm=worker.

ok so there are good chances that 2.6.5-aa5 will fix it, if not then
please notify me again, thanks.
