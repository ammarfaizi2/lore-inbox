Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTGCPty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTGCPty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:49:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:16912 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264593AbTGCPsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:48:06 -0400
Subject: Re: 2.5.74-mm1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org>
References: <20030703023714.55d13934.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1057248147.599.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 03 Jul 2003 18:02:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 11:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm1/
> 
> . Included Con's CPU scheduler changes.  Feedback on the effectiveness of
>   this and the usual benchmarks would be interesting.
> 
>   Changes to the CPU scheduler tend to cause surprising and subtle problems
>   in areas where you least expect it, and these do take a long time to
>   materialise.  Alterations in there need to be made carefully and cautiously.
>   We shall see...

Currently testing all the new things...

>From what I've seen until date, the new scheduler patches are very, very
promising. I like them very much, but I still prefer Mike+Ingo combo
patch a little bit more for my laptop.

Will keep you informed if I see something strange ;-)

