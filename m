Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbULYVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbULYVlk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbULYVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:41:40 -0500
Received: from coderock.org ([193.77.147.115]:24798 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261573AbULYVlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:41:37 -0500
Date: Sat, 25 Dec 2004 22:41:45 +0100
From: Domen Puncer <domen@coderock.org>
To: linux-kernel@vger.kernel.org
Subject: Re: delete unused file
Message-ID: <20041225214145.GA3764@masina.coderock.org>
References: <20041225134120.050934DC0EB@golobica.uni-mb.si> <20041225191126.GA3219@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225191126.GA3219@twiddle.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/04 11:11 -0800, Richard Henderson wrote:
> On Sat, Dec 25, 2004 at 02:41:28PM +0100, domen@coderock.org wrote:
> >  kj/arch/alpha/lib/dbg_stackcheck.S |   27 ---------------------------
> 
> As should be obvious from the "dbg" prefix, these are debugging aids.
> Do not remove any of them.

Obvious? Not to me :-)
It looked like they were debugging aids (no change >2 years) and they
are not needed anymore (or there would be a DEBUG_blah).

Patch dropped.


	Domen
