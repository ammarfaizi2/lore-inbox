Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTEVSky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTEVSky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:40:54 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:10728 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263078AbTEVSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:40:53 -0400
Subject: Re: 2.5.69-mm8
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030522021652.6601ed2b.akpm@digeo.com>
References: <20030522021652.6601ed2b.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1053629620.596.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 22 May 2003 20:53:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 11:16, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
> 
> . One anticipatory scheduler patch, but it's a big one.  I have not stress
>   tested it a lot.  If it explodes please report it and then boot with
>   elevator=deadline.
> 
> . The slab magazine layer code is in its hopefully-final state.
> 
> . Some VFS locking scalability work - stress testing of this would be
>   useful.

Running on it right now... Compiles and boots. I'm sure it won't explode
on my face :-)

