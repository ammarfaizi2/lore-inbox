Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265480AbTLHQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTLHQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:39:55 -0500
Received: from mail3.noris.net ([62.128.1.28]:45745 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id S265480AbTLHQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:32:22 -0500
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U}
To: Rob Love <rml@tech9.net>
Subject: Re: question about preempt_disable()
Date: Mon, 8 Dec 2003 17:31:27 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana> <pan.2003.11.30.17.39.47.71027@smurf.noris.de> <1070250821.1158.45.camel@localhost>
In-Reply-To: <1070250821.1158.45.camel@localhost>
X-Face: xyzzy
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312010703.19113@smurf.noris.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rob Love wrote:
> Further, on uniprocessor systems, we don't have deadlocks so it is the
> preempt_disable() that actually ensures concurrency is prevented in the
> critical region.
>
We don't have _spin_locks.

-- 
Matthias Urlichs    |    {M:U} IT Design @ m-u-it.de     |    smurf@debian.org
Disclaimer: The quote was selected randomly. Really. | http://smurf.debian.net
 - -
I don't care how poor and inefficient a country is; they like to run their
own business. I know men that would make my wife a better husband than I am;
but, darn it, I'm not going to give her to 'em.
					-- Will Rogers

