Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSGELqj>; Fri, 5 Jul 2002 07:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317193AbSGELqi>; Fri, 5 Jul 2002 07:46:38 -0400
Received: from [195.223.140.120] ([195.223.140.120]:13642 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317023AbSGELqi>; Fri, 5 Jul 2002 07:46:38 -0400
Date: Fri, 5 Jul 2002 13:49:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa1
Message-ID: <20020705114956.GB7734@dualathlon.random>
References: <20020629023459.GA1531@inspiron.ols.wavesec.org> <20020630230544.GA1766@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020630230544.GA1766@werewolf.able.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 01:05:44AM +0200, J.A. Magallon wrote:
> 
> On 2002.06.29 Andrea Arcangeli wrote:
> >Only booted it on the laptop so far.
> >
> >URL:
> >
> >	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1.gz
> >	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1/
> >
> 
> Booted ? 

booted, because menuconfig works as expected, it's just xconfig that
complains.

now I changed to "=" that fixes it, thanks for noticing.

Andrea
