Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755703AbWKRBOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbWKRBOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbWKRBOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:14:24 -0500
Received: from khc.piap.pl ([195.187.100.11]:7111 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1755703AbWKRBOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:14:23 -0500
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
References: <20061116153444.GC8238@csclub.uwaterloo.ca>
	<9a8748490611161249t406768beqeaff0fc31f96e8df@mail.gmail.com>
	<20061116212140.GP8236@csclub.uwaterloo.ca>
	<9a8748490611161330k124e34a5s8ede7df810d7bbc4@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 18 Nov 2006 02:14:20 +0100
In-Reply-To: <9a8748490611161330k124e34a5s8ede7df810d7bbc4@mail.gmail.com> (Jesper Juhl's message of "Thu, 16 Nov 2006 22:30:03 +0100")
Message-ID: <m3irhda74j.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> Or just try a few random older 2.6 kernels like 2.6.14, 2.6.9,
> 2.6.whatever (of course it needs to be a version that git knows
> about).

One can also do "bisect" manually, works with all kernels.
-- 
Krzysztof Halasa
