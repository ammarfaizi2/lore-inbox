Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbRE3Jic>; Wed, 30 May 2001 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRE3JiW>; Wed, 30 May 2001 05:38:22 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:18194 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S262683AbRE3JiQ>; Wed, 30 May 2001 05:38:16 -0400
To: anuradha@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler warning fix in aci.c
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.21.0105301100130.273-100000@presario>
In-Reply-To: <Pine.LNX.4.21.0105300125420.424-100000@presario>
	<Pine.LNX.4.21.0105301100130.273-100000@presario>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010530113700W.siemer@panorama.hadiko.de>
Date: Wed, 30 May 2001 11:37:00 +0200
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anuradha Ratnaweera <anuradha@gnu.org>
> On Wed, 30 May 2001, Anuradha Ratnaweera wrote:
> 
> > Following patch fixes a compiler warning in aci.c.
> 
> I can guess the usefullness of the functiion print_bits that would be
> removed if my patch is applied. If this is so, how about putting it
> inside an "#ifdef DEBUG"?

This is exactly what I did some month ago with my little working tree.

Anyway: are you using some aci-supported hardware? Which one?


Bye,
	Robert

PS: I'm not subscribed to linux-kernel.
