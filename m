Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUFYKDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUFYKDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266690AbUFYKDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:03:00 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:64773 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266687AbUFYKC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:02:59 -0400
Date: Fri, 25 Jun 2004 12:02:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jgarzik@pobox.com>,
       Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Message-ID: <20040625100256.GB4946@pclin040.win.tue.nl>
References: <200406240020.39735.mmazur@kernel.pl> <40DA0F7D.60606@pobox.com> <m3n02s9a9f.fsf@defiant.pm.waw.pl> <20040625092557.GG27805@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040625092557.GG27805@admingilde.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 11:25:57AM +0200, Martin Waitz wrote:

>  * mkdir include/kernel (plus arch-specific versions)
>  * add placeholer files that simply #include the old include/linux file
>  * start replacing in-kernel #includes with the include/kernel version.
>  * move the #ifdef __KERNEL__ parts from include/linux to include/kernel

See http://www.uwsg.iu.edu/hypermail/linux/kernel/0007.3/1008.html

(and e.g. http://lwn.net/Articles/51754/ )

