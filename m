Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317970AbSGLBfp>; Thu, 11 Jul 2002 21:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSGLBfo>; Thu, 11 Jul 2002 21:35:44 -0400
Received: from [195.223.140.120] ([195.223.140.120]:24178 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317970AbSGLBfn>; Thu, 11 Jul 2002 21:35:43 -0400
Date: Fri, 12 Jul 2002 01:00:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsync fixes for 2.4
Message-ID: <20020711230013.GO1342@dualathlon.random>
References: <20020710202036.GA1342@dualathlon.random> <20020711215739.GA6641@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711215739.GA6641@werewolf.able.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 11:57:39PM +0200, J.A. Magallon wrote:
> 
> On 2002.07.10 Andrea Arcangeli wrote:
> >At polyserve they found a severe problem with fsync in 2.4.
> [patch trimmed]
> 
> Does this apply also to  -aa, or other changes make it unnecessary ?

I submitted it for mainline before porting it to -aa, so -aa is missing
it too at the moment (I just have it in my devel tree, so it will be
automatically included in the next one).

Andrea
