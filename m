Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTGWMR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270240AbTGWMR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:17:59 -0400
Received: from [163.118.102.59] ([163.118.102.59]:29071 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S270230AbTGWMR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:17:58 -0400
Date: Wed, 23 Jul 2003 08:19:46 -0400
From: paterley <paterley@DrunkenCodePoets.com>
To: Jason <jason@project-lace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD MP, SMP, Tyan 2466
Message-Id: <20030723081946.44d4fe10.paterley@DrunkenCodePoets.com>
In-Reply-To: <1058846559.8494.17.camel@big-blue.project-lace.org>
References: <BB41BCD3.17A02%kernel@mousebusiness.com>
	<1058846559.8494.17.camel@big-blue.project-lace.org>
Organization: DrunkenCodePoets.com
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2003 00:02:39 -0400
Jason <jason@project-lace.org> wrote:

> Hello,
> 
> I'm coming into this conversation a bit late, so I might be missing
> something and appologize if I am.  But  I have the same board and
> experienced some intersting weirdness with PC2100 NON ECC chips on this
> board as well.  I was using High performance ram from Mushkin at the
> time.  Now here's the interesting part, according to some small print in
> the manual, non ecc ram works up to 1.5Gb.  Knowing this, I bought 1Gb
> of it, 2 512MB sticks.  I put them both in, and the board only sees
> 512Mb.  So I talk to Mushkin about it, apparently they've done some
> testing with this board.  Non ECC memory is EXTREMELY flakey in this
> board.  So flakey that Tyan, unofficially mind you, recommened to them
> that they not suggest to their customers to put non ecc memory in this
> board.  So I got 1Gb of ECC Registered memory, and have yet to have a
> problem with it.

Actually, your 2 dimm problem could have (probably) been solved by rearranging
your dimms.  I have the 2462ung (thunder k7) and the only way I could get 512 
megs (give me a break I'm a porr college student) was to put one in slot 1 and 
one in slot 3 (numbering starting at 0).

Pat Erley-- 
