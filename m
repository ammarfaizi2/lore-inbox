Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUF2El0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUF2El0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUF2El0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:41:26 -0400
Received: from are.twiddle.net ([64.81.246.98]:50572 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S265429AbUF2ElV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:41:21 -0400
Date: Mon, 28 Jun 2004 21:40:59 -0700
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: __setup()'s not processed in bk-current
Message-ID: <20040629044059.GA12344@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@muc.de>
References: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net> <20040628165707.328cce15.akpm@osdl.org> <1088477020.10622.82.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088477020.10622.82.camel@bach>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 12:43:41PM +1000, Rusty Russell wrote:
> There are a number of places where we assume that we can iterate through
> all entries in a section as an array, rth would know if we've just been
> lucky...

You've been lucky.


r~
