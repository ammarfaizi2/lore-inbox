Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSFBBqk>; Sat, 1 Jun 2002 21:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317108AbSFBBqk>; Sat, 1 Jun 2002 21:46:40 -0400
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:33212 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317107AbSFBBqj>; Sat, 1 Jun 2002 21:46:39 -0400
Subject: Re: P4 hyperthreading
From: Louis Garcia <louisg00@bellsouth.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206011842370.976-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jun 2002 21:39:31 -0400
Message-Id: <1022981972.2456.10.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just thinking about that. Do you now if this has a real speed
improvement?

--Lou

On Sat, 2002-06-01 at 21:44, Davide Libenzi wrote:
> On 1 Jun 2002, Louis Garcia wrote:
> 
> > Did I forget to say this is a UP box? I just wanted to know if
> > hyperthreading is stable for a UP P4 box. Will acpismp=force still help?
> 
> CONFIG_SMP must be on. the fact that you have a single CPU does not mean
> that spinlocks have to resolve to {} with ht
> 
> 
> 
> - Davide
> 
> 


