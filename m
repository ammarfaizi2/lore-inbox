Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266508AbRGLSws>; Thu, 12 Jul 2001 14:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbRGLSw2>; Thu, 12 Jul 2001 14:52:28 -0400
Received: from ns.suse.de ([213.95.15.193]:60428 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266518AbRGLSwZ>;
	Thu, 12 Jul 2001 14:52:25 -0400
Date: Thu, 12 Jul 2001 20:52:18 +0200 (CEST)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Oops triggered by ftp connection attempt through Linux firewall
To: ned@linuxcare.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010712101219.D5476@linuxcare.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010712205124.C649DABCC@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul, Ned Bass wrote:

> I wish to be personally CC'ed the answers/comments posted to the list
> in response to my posting.
 
> [1.] One line summary of the problem:     
> Ftp connection attempt through Linux firewall triggers kernel Oops.

 Thanks for this fullyfledged bugreport. I've been seeing this for quite
 some time on my personal firewall machine which masquerades a pppoe
 connection for a home network however I've not been able to produce
 an oops and therefore I've had no clue what exactly the problem might
 be. I've seen this problem with every 2.4.x kernel so far with
 completely different machines and different NICs doing the same job,
 my favourite way to reproduce this is having my friend use gnutella
 though which is a really trivial method to produce this lockup.

Servus,
       Daniel

