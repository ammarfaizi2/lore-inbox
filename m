Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbREBEeh>; Wed, 2 May 2001 00:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbREBEe1>; Wed, 2 May 2001 00:34:27 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:5125 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132561AbREBEeV>; Wed, 2 May 2001 00:34:21 -0400
Message-Id: <200105020434.f424YHs81825@aslan.scsiguy.com>
To: believe@primenet.com
cc: linux-kernel@vger.kernel.org
Subject: Re: New aic7xxx driver locking disk access 
In-Reply-To: Your message of "Mon, 30 Apr 2001 02:32:05 EDT."
             <20010430023205.A1707@zanzibar.yi.org> 
Date: Tue, 01 May 2001 22:34:17 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>1. New aic7xxx driver locking disk access

The 6.1.5 version of the aic7xxx driver is quite stale.  Can
you try 6.1.13 from:

http://people.FreeBSD.org/~gibbs/linux/

and see if this clears up your problem?

Thanks,
Justin
